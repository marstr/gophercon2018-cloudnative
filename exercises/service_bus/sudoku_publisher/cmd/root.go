// Copyright © 2018 Martin Strobel

package cmd

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"time"

	"github.com/Azure/azure-service-bus-go"
	"github.com/marstr/gophercon2018-cloudnative/exercises/cancellation/sudoku"
	homedir "github.com/mitchellh/go-homedir"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

const (
	namespaceConnection       = "namespace-connection"
	namespaceConnectionEnvVar = "SERVICE_BUS_CONNECTION_STRING"

	topicName        = "topic"
	topicEnvVar      = "SERVICE_BUS_TOPIC"
	topicNameDefault = "random_ids"

	logLevel = "log-level"

	messageCount = "message-count"
)

var messageRate time.Duration

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "sudoku_publisher",
	Short: "Sends random Sudoku puzzles to an Azure Service Bus Topic.",
	Run: func(cmd *cobra.Command, args []string) {
		ctx, cancel := context.WithCancel(context.Background())
		go func() {
			fmt.Scanln()
			logrus.Info("cancelling on user request")
			cancel()
		}()

		connStr := viper.GetString(namespaceConnection)
		logrus.Debug(connStr)
		ns, err := servicebus.NewNamespace(servicebus.NamespaceWithConnectionString(connStr))
		if err != nil {
			logrus.Fatalf("Unable to connect to Service Bus Namespace: %v", err)
		}

		client, err := ns.NewTopic(ctx, viper.GetString(topicName))
		if err != nil {
			logrus.Fatalf("Unable to create Topic client: %v", err)
		}

		i := int64(0)
		n := viper.GetInt64(messageCount)
		for {
			if i >= n {
				break
			} else if n != 0 {
				i++
			}

			board, err := sudoku.GenerateBoard(40)
			if err != nil {
				logrus.Errorf("Unable to generate message: %v", err)
				continue
			}

			marshaled, err := json.Marshal(board)
			if err != nil {
				logrus.Errorf("Unable to serialize board")
				continue
			}
			msg := servicebus.NewMessage(marshaled)

			err = client.Send(ctx, msg)
			if err == nil {
				logrus.Info("sent message")
			} else {
				logrus.Errorf("Unable to send message: %v", err)
			}

			select {
			case <-ctx.Done():
				return
			case <-time.After(messageRate):
				// Intentionally Left Blank
			}
		}
	},
	Args: func(cmd *cobra.Command, args []string) error {
		// Ensure that a namespace connection string was provided.
		if connection := viper.GetString(namespaceConnection); connection == "" {
			return errors.New("No Service Bus connection string provided")
		}

		// Ensure that if a log-level was specified, that it is recognized by logrus
		if ll, err := logrus.ParseLevel(viper.GetString("log-level")); err == nil {
			logrus.SetLevel(ll)
		} else {
			out := bytes.NewBufferString("Log Level must be one of:\n")
			for _, validLevel := range logrus.AllLevels {
				fmt.Fprintln(out, "\t", validLevel.String())
			}
			return errors.New(out.String())
		}

		// Validate the message rate that was provided.
		if parsed, err := time.ParseDuration(viper.GetString("message-rate")); err == nil {
			messageRate = parsed
		} else {
			return errors.New("message-rate must be parse-able by time.ParseDuration")
		}

		// If any other arguments are provided, wag the finger.
		return cobra.NoArgs(cmd, args)
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)

	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.
	// rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.sudoku_publisher.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	// rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

	viper.BindEnv(namespaceConnection, namespaceConnectionEnvVar)
	viper.BindEnv(topicName, topicEnvVar)

	viper.SetDefault(logLevel, logrus.InfoLevel)
	viper.SetDefault("message-rate", (2 * time.Second).String())
	viper.SetDefault(topicName, topicNameDefault)

	shortenedServiceBusKey := viper.GetString(namespaceConnection)
	if len(shortenedServiceBusKey) > 25 {
		shortenedServiceBusKey = shortenedServiceBusKey[:25] + "..."
	}

	rootCmd.Flags().StringP(
		namespaceConnection,
		"c",
		shortenedServiceBusKey,
		"The connection string (including SharedAccessKey) to the Service Bus Namespace in use.")
	rootCmd.Flags().StringP(
		topicName,
		"t",
		viper.GetString(topicName),
		"The name of the Service Bus Topic to be published to.")
	rootCmd.Flags().StringP(
		logLevel,
		"l",
		viper.GetString("log-level"),
		"The verbosity of log output.")
	rootCmd.Flags().StringP(
		"message-rate",
		"r",
		viper.GetString("message-rate"),
		"The duration that should be waited between each send event.")

	rootCmd.Flags().Int64P(messageCount, "n", 0, "The number of puzzles to publish.")

	viper.BindPFlags(rootCmd.Flags())
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		// Search config in home directory with name ".sudoku_publisher" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".sudoku_publisher")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}
