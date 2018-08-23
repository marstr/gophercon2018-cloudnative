// Copyright © 2018 Martin Strobel

package cmd

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"os"
	"time"

	"github.com/Azure/azure-service-bus-go"
	homedir "github.com/mitchellh/go-homedir"
	"github.com/satori/uuid"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

const (
	serviceBusEnvVar       = "SERVICE_BUS_CONNECTION_STRING"
	serviceBusKey          = "namespace-connection"
	serviceBusTopicNameKey = "topic"
	serviceBusTopicEnvVar  = "SERVICE_BUS_TOPIC"
	serviceBusTopicDefault = "random_ids"
)

var messageRate time.Duration

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "publisher",
	Short: "Sends random UUIDs to an Azure Service Bus Queue or Topic.",
	Run: func(cmd *cobra.Command, args []string) {
		ctx, cancel := context.WithCancel(context.Background())
		go func() {
			fmt.Scanln()
			cancel()
		}()

		connStr := viper.GetString(serviceBusKey)
		logrus.Debug(connStr)
		ns, err := servicebus.NewNamespace(servicebus.NamespaceWithConnectionString(connStr))
		if err != nil {
			logrus.Fatalf("Unable to connect to Service Bus Namespace: %v", err)
		}

		// topics, err := ns.NewTopicManager().List(ctx)
		// if err != nil {
		// 	logrus.Fatalf("Unable to list Topics: %v", err)
		// }

		// for i := range topics {
		// 	logrus.Info("Found Topic: ", topics[i].Name)
		// }

		client, err := ns.NewTopic(ctx, viper.GetString(serviceBusTopicNameKey))
		if err != nil {
			logrus.Fatalf("Unable to create Topic client: %v")
		}

		for {

			id := uuid.NewV4()
			msg := servicebus.NewMessage(id[:])

			err = client.Send(ctx, msg)
			if err == nil {
				logrus.Infof("%s sent message", id)
			} else {
				logrus.Errorf("%s Unable to send message: %v", id, err)
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
		if connection := viper.GetString(serviceBusKey); connection == "" {
			return errors.New("No Service Bus connection")
		}

		if ll, err := logrus.ParseLevel(viper.GetString("log-level")); err == nil {
			logrus.SetLevel(ll)
		} else {
			out := bytes.NewBufferString("Log Level must be one of:\n")
			for _, validLevel := range logrus.AllLevels {
				fmt.Fprintln(out, "\t", validLevel.String())
			}
			return errors.New(out.String())
		}

		if parsed, err := time.ParseDuration(viper.GetString("message-rate")); err == nil {
			messageRate = parsed
		} else {
			return errors.New("message-rate must be parse-able by time.ParseDuration")
		}

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
	// rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.publisher.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	// rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

	viper.BindEnv(serviceBusKey, serviceBusEnvVar)
	viper.BindEnv(serviceBusTopicNameKey, serviceBusTopicEnvVar)

	viper.SetDefault("log-level", logrus.InfoLevel)
	viper.SetDefault("message-rate", (2 * time.Second).String())

	rootCmd.Flags().StringP(serviceBusKey, "c", viper.GetString(serviceBusKey)[:25]+"...", "The connection string (including SharedAccessKey) to the Service Bus Namespace in use.")
	rootCmd.Flags().StringP(serviceBusTopicNameKey, "t", viper.GetString(serviceBusTopicNameKey), "The name of the Service Bus Topic to be published to.")
	rootCmd.Flags().StringP("log-level", "l", viper.GetString("log-level"), "The verbosity of log output.")
	rootCmd.Flags().StringP("message-rate", "r", viper.GetString("message-rate"), "The duration that should be waited between each send event.")

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

		// Search config in home directory with name ".publisher" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".publisher")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}
