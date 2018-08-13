---
title: Cloud-Native Go
presenters: Josh Gavant; Martin Strobel
summary: Use managed platforms, managed services and continuous delivery pipelines to build cloud apps.
original_date: 2018-08-27
---

# Summary

A cloud-native app comprises continuously-delivered communicating microservices
built on runtimes and services managed by an underlying platform. In this
workshop we'll dive into how each of these attributes of a cloud-native app can
be achieved using modern clouds like Microsoft Azure. We'll follow with a
hands-on lab demonstrating how to build a cloud-native app (an Athens proxy) on
Azure platforms and services.

We'll cover the following topics in particular:

1. Microservices and the compute runtimes that run them
2. Communicating microservices: from RPC to service mesh, protocols and
   paradigms to consider
3. Best practices for using platform services like data and blob storage,
   message and event systems, and authentication and directories
4. Continuous delivery using container builders and registries


# Contents

1. Introduction and Overview
2. Microservices and managed compute
3. Communicating microservices
4. Managed platform services
5. Continuous delivery with container registries
6. Exercise: Build a cloud-native app (Athens)


# 1. Introduction, Overview

Length: 70 minutes

## Introduction

* Who are we? Who are you?
* What to expect today? What are you expecting today?

## Overview: What is a cloud-native app?

A cloud-native app comprises continuously-delivered communicating microservices
built on runtimes and services managed by an underlying platform.

1. Microservices
2. Communicating microservices
3. Managed platform services
4. Continuous Delivery

### Demos

Show a diagram of a "cloud-native app", then show working implementation of
this app. Highlight regions corresponding to each of the above domains.


# 2. Microservices and managed compute

Length: 70 minutes

A microservice is a self-contained compute process or set of processes which
interacts with other services through a defined and shared API contract.

A microservice may be contained in a container image or pod definition, for
example.

### Topics

* Where to run a microservice? Choose something which matches the needs of the
  service from the spectrum of cloud compute: Functions, Web Apps, Containers,
  Pods, Apps and Clusters.
* PaaS: managed OS and language runtimes, value-added features like diagnostics
  and authentication
* Functions and Serverless: Azure Functions and Event Grid
* Containers: more control with portability
* Buffalo and Rapid App Dev
* Clusters: Manage containers at scale. What is an orchestrator and why is it
  needed?

### Demos:

* Deploy a container to Web Apps, ACI, and AKS.
* Handle Event Grid event in a Buffalo web app.
* Handle Event Grid event in a Function.


# 3. Communicating microservices

Length: 70 minutes

Communication with a microservice could use one of several common protocols,
such as JSON-RPC and grpc; or perhaps AMQP and NATS. The communication layer
can be abstracted with a managed service mesh or bus.

### Topics

* Factors to consider when choosing an app communication layer:
    * guaranteed message delivery, transactions, auditing
    * tracking requests as they transit many services
    * handle high volume of messages, e.g. from logs and sensors
    * protocols and projects: HTTP vs. AMQP, AMQP 0.9 vs. 1.0
* What's wrong with HTTP? E.g. lots of overhead, direct node-to-node at risk of
  failure of sender or target. Consider: HTTP/2, TCP, AMQP.
* What's wrong with RPC? Direct node to node at risk of failure. Consider mesh
  or bus.
* What is a service mesh? What is a service broker or bus?
* Gateways: API Gateways, Event Gateways, Azure Event Grid
* What about caches, and how do they relate to queues? Kafka, Redis.

### Demos

* Use a service mesh, use Azure Service Bus, to accomplish same goal.
* Send a message directly from one node to another, fail a node.
* Send a message via Service Bus, fail a node, have another node pick up message.


# 4. Managed platform services

Length: 70 minutes

Use services provided by the platform when possible. Choose open protocols and
implementations to achieve greater (if not unlimited) flexibility.

### Topics

* Choose open protocols and and open implementations, but expect some
  provider-specific configuration.
* Should you run the implementation yourself or rely on a managed service?
    * Who runs the world? Apache Zookeeper and etcd. You probably don't want to
      run this.
* The spectrum of cloud storage: databases, blobs, queues; consistency; cost;
  performance.
* The specturm of messaging systems: Azure Event Hubs, Service Bus; Amazon MQ,
  SQS; GCP Pub/Sub; Apache Kafka, RabbitMQ, Redis
* Delegate authentication, authorization and user directories to identity
  providers through OAuth, OpenIDConnect and Graph APIs.
* Use managed intelligence/cognitive services in your data processing
  pipelines.


# 5. Continuous delivery

Length: 70 minutes

Apply and deploy changes and updates to your apps immediately with confidence.

### Topics

* Describe reproducible environments with container images and
  infrastructure-as-code.
* Use container registries and builders to share implementations.
    * set up registries with automatic build-on-commit
    * associate registry images with compute runtimes with webhooks
    * describe other infrastructure as code with ARM or Terraform templates, or
      Azure CLI
* Augment basic build with test and analysis services, e.g. from VSTS.
* (?) Manage other types of packages such as npm, Maven, nuget and gomods.


# 6. Exercise: Build a cloud-native app

Length: 120 minutes

Athens!

