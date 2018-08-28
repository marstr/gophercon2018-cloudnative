// Copyright © 2018 Martin Strobel

package cmd

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"

	"github.com/Azure/azure-service-bus-go"
	"github.com/marstr/gophercon2018-cloudnative/exercises/cancellation/sudoku"
	"github.com/mitchellh/go-homedir"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

const (
	namespaceConnection       = "namespace-connection"
	namespaceConnectionEnvVar = "SERVICE_BUS_CONNECTION_STRING"

	subscriptionName        = "subscription"
	subscriptionNameDefault = "solver1"
	subcriptionNameEnvVar   = "SERVICE_BUS_SUBSCRIPTION"

	topicName        = "topic"
	topicEnvVar      = "SERVICE_BUS_TOPIC"
	topicNameDefault = "random_ids"

	logLevel = "log-level"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "sudoku_subscriber",
	Short: "Listens to a Service Bus Subscription, solving Sudoku puzzles that are sent across.",
	Run: func(cmd *cobra.Command, args []string) {
		ctx, cancel := context.WithCancel(context.Background())
		defer cancel()

		ns, err := servicebus.NewNamespace(
			servicebus.NamespaceWithConnectionString(viper.GetString(namespaceConnection)))

		if err != nil {
			panic(err)
		}

		topic, err := ns.NewTopic(ctx, viper.GetString(topicName))
		if err != nil {
			panic(err)
		}

		sub, err := topic.NewSubscription(ctx, viper.GetString(subscriptionName))
		if err != nil {
			panic(err)
		}

		handle, err := sub.Receive(ctx, Solve)
		if err != nil {
			panic(err)
		}

		<-handle.Done()
	},
	Args: func(cmd *cobra.Command, args []string) error {
		// Ensure that a namespace connection string was provided.
		if connection := viper.GetString(namespaceConnection); connection == "" {
			return errors.New("No Service Bus connection string provided")
		}

		// Ensure that if a log-level was specified, that it is recognized by logrus
		if ll, err := logrus.ParseLevel(viper.GetString(logLevel)); err == nil {
			logrus.SetLevel(ll)
		} else {
			out := bytes.NewBufferString("Log Level must be one of:\n")
			for _, validLevel := range logrus.AllLevels {
				fmt.Fprintln(out, "\t", validLevel.String())
			}
			return errors.New(out.String())
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

func Solve(ctx context.Context, msg *servicebus.Message) servicebus.DispositionAction {
	var target sudoku.Board
	err := json.Unmarshal(msg.Data, &target)
	if err != nil {
		return msg.DeadLetter(err)
	}

	_, err = sudoku.ManyToOneConverter(sudoku.BasicManySolver).Solve(ctx, target)
	if err != nil {
		return msg.DeadLetter(err)
	}

	fmt.Println("solved!")
	return msg.Complete()
}

func init() {
	cobra.OnInitialize(initConfig)

	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.
	// rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.sudoku_subscriber.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	// rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

	viper.SetDefault(topicName, topicNameDefault)
	viper.SetDefault(subscriptionName, subscriptionNameDefault)
	viper.SetDefault(logLevel, logrus.InfoLevel.String())

	viper.BindEnv(namespaceConnection, namespaceConnectionEnvVar)
	viper.BindEnv(subscriptionName, subcriptionNameEnvVar)

	rootCmd.Flags().StringP(
		namespaceConnection,
		"c",
		viper.GetString(namespaceConnection),
		"A Service Bus connection string to use.")
	rootCmd.Flags().StringP(
		subscriptionName,
		"s",
		viper.GetString(subscriptionName),
		"The name of the Service Bus Subscription to listen too.")
	rootCmd.Flags().StringP(topicName,
		"t",
		viper.GetString(topicName),
		"The Service Bus Topic to be received from.")

	rootCmd.Flags().StringP(logLevel, "l", viper.GetString(logLevel), "The verbosity of output.")

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

		// Search config in home directory with name ".sudoku_subscriber" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".sudoku_subscriber")
	}

	// viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}
