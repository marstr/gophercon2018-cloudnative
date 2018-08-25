# Brokered Messaging

In these exercises you'll explore communicating between services using a broker 
instead of making direct RPC calls.

## Exercise 1

Modify [sudoku_subscriber](./sudoku_subscriber/cmd/root.go) so that it listens 
to the Topic Subscription provided to you. The subscription will receive 
messages that are JSON formatted Sudoku boards. As in the previous exercise, it
is your job to solve them. For exercise 1, it is only expected that you print
each puzzle and its solution to the console.


You'll need to:

1.  Write a method that calls your solver from the 
    [cancellation exercises](../cancellation/README.md) , and is a 
    `servicebus.Handler`. i.e. it must be of type:

    ``` Go
    type Handler func(context.Context, *servicebus.Message) servicebus.DispositionAction
    ```
    
    Like implementing an HTTP operation, you'll be required to receive a 
    [message](https://godoc.org/github.com/Azure/azure-service-bus-go#Message)
    with metadata and payload. Unlike most RESTful HTTP services that you've 
    implemented, the response the broker expects is only `Complete`, 
    `Abandoned`, or `DeadLetter`. Casually defined, they mean the following:
    
    | Response                                                                                 | Meaning                                                                        |
    | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
    | [Complete](https://godoc.org/github.com/Azure/azure-service-bus-go#Message.Complete)     | Message has been handled, the broker doesn't need to worry about it anymore.   |
    | [Abandon]((https://godoc.org/github.com/Azure/azure-service-bus-go#Message.Abandon))     | This client wasn't able to deal with this message, but another may be able to. |
    | [DeadLetter](https://godoc.org/github.com/Azure/azure-service-bus-go#Message.DeadLetter) | This client wasn't able to deal with this message, and it is likely poison.    |
    
    > Note: If your client doesn't respond within 60 seconds, the broker will 
    assume that the client will never respond and automatically assume a 
    response of `Abandoned`. 
    
1.  Begin listening to events published to the Service Bus Topic 
    "random_puzzles" by calling `Receive` with the `Handler` you wrote in step
    one. To do this you'll need to instantiate clients for each Service Bus 
    entity being used:
    - [Namespace](https://godoc.org/github.com/Azure/azure-service-bus-go#Namespace)
    - [Topic](https://godoc.org/github.com/Azure/azure-service-bus-go#Topic)
    - [Subscription](https://godoc.org/github.com/Azure/azure-service-bus-go#Subscription)
