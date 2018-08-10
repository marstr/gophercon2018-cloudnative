# Cloud-Native Go

* Utilize communicating microservices and managed platform services to compose
  scalable and flexible cloud apps.
* Use patterns and designs in your code that maximize concurrency and
  event-driven architecture.
* Use deployment tools and services to automate release and monitoring of your
  apps.

---

# Agenda

1. Introduction
2. Overview: What is a cloud-native app?
3. Compute
4. Messages and Events
5. Data and Storage
6. Authentication
7. Deployment and Monitoring
8. Build a cloud-native app (Athens)

---

# 1. Introduction

* Who are we? Who are you?
* What to expect today, what are you expecting today?

---

# 2. Overview: What is a cloud-native app?

### potential examples: Athens, vanpool-manager, song-manager

* Show architecture diagram of a cloud-native app (Athens) and demonstrate it in action, then utilize to discuss following items.
    * As we discuss following items, highlight corresponding parts of diagram/demo.
* Composed of microservices: small components communicating via RPC/API contracts.
* Built on managed platform and managed services: from serverless to PaaS to managed clusters (Kubernetes), managed dbs and caches, managed auth and directory.
* Reactive, asynchronous, event-driven.
* Continuously integrated and deployed: Infrastructure as code, automated test and deploy.

**Cloud-native apps** comprise componentized microservices and managed platform
services. They can be deployed and updated nearly instantaneously. Components
are loosely-coupled by well-defined API contracts and flexible to changes in
other components. 

### Parts:

Highlight different aspects of architecture diagram which following modules will dive into:

* **compute**: managed OS (PaaS), managed language runtime (Functions), containers, container clusters
* **messages and events**: direct RPC, asynchronus queues and pubsub, reliable messages and transactions, observability
* **data and storage**: blobs, databases, caches, queues
* **authentication**: delegated via OAuth, OpenIDConnect
* **deployment and monitoring**: infra as code, build/integration services, package management, instrument code, gather and view traces and metrics

---

# 3. Compute

### Demos:

* Handle Event Grid event in a Function.
* Handle Event Grid event in a Buffalo web app.
* Deploy a container to Web Apps, ACI, and AKS.

### Topics

* Functions and Serverless: Azure Functions and Event Grid
* PaaS: managed OS and language runtimes, value-added features like diagnostics and authentication
* Containers: more control with portability
* Clusters: Manage containers at scale
    * What is an orchestrator and why is it needed?

---

# 4. Messages and Events

### Demos:

* Send a message directly from one node to another, fail a node.
* Send a message via Service Bus, fail a node, have another node pick up message.

### Topics:

* What's wrong with HTTP? Lots of overhead, direct node-to-node at risk of failure of sender or target.
* What's wrong with RPC? Direct node to node at risk of failure.
* What is a service mesh?
* Broker vs mesh
* Gateways: API Gateways, Event Gateways, Azure Event Grid
* What about caches? Kafka, Redis.
* Are messages the same as events?

---

# 5. Data and Storage

### Demos:

### Topics:

* Databases: NoSQL, Relational
* Caches and queues
* Blobs

---

# 6. Authentication

### Demos:

### Topics:

* Delegate, delegate, delegate! with OAuth and OpenIDConnect

---

# 7. Deployment and Monitoring

### Demos:

* Azure CLI
* Terraform
* Azure RM

### Topics:

* Infrastructure as Code, reproducible infrastructure
* Monitoring: OpenCensus, Prometheus, dashboards, etc.

---

# 8. Build a cloud-native app

Athens!

