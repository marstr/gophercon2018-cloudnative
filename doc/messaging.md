# Interservice Communication

## What do you want from Inter-service communication?
- Well encapsulated logic
- Insulation from scalability points.

## Communication Non-Sequitors

- Difference between an `error` and a `4**` response.
- Retry strategies, 429 vs other
- Large payloads can be stashed in cloud storage.
- Differentiate between not sent, and sent as empty. e.g. Why are there pointers everwhere in Cloud provider libraries?
- Go composition based, other languages inheritance based. This leads to 
  non-sequitors around list contents. (Basically, type slicing)

## Using a Side Car
- When the logic of communicating between your services gets too specific, isolate that logic into a sidecar service that takes care of it for you.
- There are some off the shelf implementations of Service Mesh sidecars, Istio is a good example.

## What is messaging?

An alternative to services communicating with one another directly.
    - 

Two scenarios for using messaging solutions:
1. Event Reaction
    - Instead of having a program poll to see if there is work to do, inform programs that it is now time to run.
    - Allows decoupling of your sevices, because folks responsible for knowing that are recognizing that.
1. Inter-service Communication
    - Unlike Pub/Sub there is a need for the originator of the event to get a response knowing the next stage has done what it needs to do.
    

## When to use Pub/Sub, why does a broker help?

- Polling weaknesses:
    - Waste of CPU cycles and bandwidth.
    - Adds delay to events, because you don't react immediately.
    - Polling logic gets duplicated for each service that listens.
- Exposing an endpoint in your service allows you to be informed when to do work, instead of always asking.
- Without a broker, the service in charge of recognizing an event has happened is also in charge of knowing who needs to be aware of it.
- Examples of Pub/Sub brokers:
  - Amazon Simple Notification System (SNS)
  - Azure EventGrid
  - Azure Service Bus Topic
  - Google Cloud Pub/Sub
- Pub/Sub is characterized by having many subscribers (optionally, many publishers), broker knows that the message was sent, but not that the message was handled.

## Deserializing HTTP based Pub/Sub Messages
- General pattern is, Event service (i.e. Event Grid) provides a JSON envelope around a payload.
    - At the moment, most services have their own Format, but a standard is emerging: https://github.com/cloudevents/spec
- In many applications, not all events should be treated the same.
    - Using [`json.RawMessage`](https://godoc.org/encoding/json#RawMessage), you can partially deserialize a message, inspect the envelope, then proceed to pass the body of the envelope on else where.

