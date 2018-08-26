resource "azurerm_resource_group" "gophercon2018" {
    name = "sbexamples"
    location = "westus2"
}

resource "azurerm_servicebus_namespace" "gophercon2018" {
    name = "gophercon2018"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    location = "${azurerm_resource_group.gophercon2018.location}"
    sku = "standard"
}

resource "azurerm_servicebus_namespace_authorization_rule" "teacher" {
  name = "teacher"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"

  listen = true
  send = true
  manage = true
}

resource "azurerm_servicebus_topic" "random_puzzles" {
    name = "random_puzzles"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_topic_authorization_rule" "random_puzzles" {
    name = "random_puzzles"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
    listen = true
    send = false
    manage = false
}


resource "azurerm_servicebus_queue" "student0-unsolved" {
    name = "student0-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student0-solved" {
    name = "student0-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student0-unsolved" {
    name = "${azurerm_servicebus_queue.student0-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student0-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student0-solved" {
    name = "${azurerm_servicebus_queue.student0-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student0-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student0" {
  name = "student0"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student1-unsolved" {
    name = "student1-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student1-solved" {
    name = "student1-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student1-unsolved" {
    name = "${azurerm_servicebus_queue.student1-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student1-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student1-solved" {
    name = "${azurerm_servicebus_queue.student1-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student1-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student1" {
  name = "student1"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student2-unsolved" {
    name = "student2-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student2-solved" {
    name = "student2-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student2-unsolved" {
    name = "${azurerm_servicebus_queue.student2-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student2-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student2-solved" {
    name = "${azurerm_servicebus_queue.student2-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student2-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student2" {
  name = "student2"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student3-unsolved" {
    name = "student3-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student3-solved" {
    name = "student3-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student3-unsolved" {
    name = "${azurerm_servicebus_queue.student3-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student3-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student3-solved" {
    name = "${azurerm_servicebus_queue.student3-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student3-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student3" {
  name = "student3"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student4-unsolved" {
    name = "student4-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student4-solved" {
    name = "student4-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student4-unsolved" {
    name = "${azurerm_servicebus_queue.student4-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student4-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student4-solved" {
    name = "${azurerm_servicebus_queue.student4-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student4-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student4" {
  name = "student4"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student5-unsolved" {
    name = "student5-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student5-solved" {
    name = "student5-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student5-unsolved" {
    name = "${azurerm_servicebus_queue.student5-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student5-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student5-solved" {
    name = "${azurerm_servicebus_queue.student5-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student5-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student5" {
  name = "student5"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student6-unsolved" {
    name = "student6-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student6-solved" {
    name = "student6-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student6-unsolved" {
    name = "${azurerm_servicebus_queue.student6-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student6-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student6-solved" {
    name = "${azurerm_servicebus_queue.student6-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student6-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student6" {
  name = "student6"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student7-unsolved" {
    name = "student7-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student7-solved" {
    name = "student7-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student7-unsolved" {
    name = "${azurerm_servicebus_queue.student7-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student7-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student7-solved" {
    name = "${azurerm_servicebus_queue.student7-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student7-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student7" {
  name = "student7"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student8-unsolved" {
    name = "student8-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student8-solved" {
    name = "student8-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student8-unsolved" {
    name = "${azurerm_servicebus_queue.student8-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student8-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student8-solved" {
    name = "${azurerm_servicebus_queue.student8-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student8-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student8" {
  name = "student8"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student9-unsolved" {
    name = "student9-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student9-solved" {
    name = "student9-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student9-unsolved" {
    name = "${azurerm_servicebus_queue.student9-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student9-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student9-solved" {
    name = "${azurerm_servicebus_queue.student9-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student9-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student9" {
  name = "student9"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student10-unsolved" {
    name = "student10-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student10-solved" {
    name = "student10-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student10-unsolved" {
    name = "${azurerm_servicebus_queue.student10-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student10-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student10-solved" {
    name = "${azurerm_servicebus_queue.student10-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student10-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student10" {
  name = "student10"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student11-unsolved" {
    name = "student11-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student11-solved" {
    name = "student11-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student11-unsolved" {
    name = "${azurerm_servicebus_queue.student11-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student11-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student11-solved" {
    name = "${azurerm_servicebus_queue.student11-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student11-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student11" {
  name = "student11"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student12-unsolved" {
    name = "student12-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student12-solved" {
    name = "student12-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student12-unsolved" {
    name = "${azurerm_servicebus_queue.student12-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student12-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student12-solved" {
    name = "${azurerm_servicebus_queue.student12-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student12-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student12" {
  name = "student12"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student13-unsolved" {
    name = "student13-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student13-solved" {
    name = "student13-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student13-unsolved" {
    name = "${azurerm_servicebus_queue.student13-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student13-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student13-solved" {
    name = "${azurerm_servicebus_queue.student13-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student13-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student13" {
  name = "student13"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student14-unsolved" {
    name = "student14-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student14-solved" {
    name = "student14-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student14-unsolved" {
    name = "${azurerm_servicebus_queue.student14-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student14-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student14-solved" {
    name = "${azurerm_servicebus_queue.student14-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student14-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student14" {
  name = "student14"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student15-unsolved" {
    name = "student15-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student15-solved" {
    name = "student15-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student15-unsolved" {
    name = "${azurerm_servicebus_queue.student15-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student15-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student15-solved" {
    name = "${azurerm_servicebus_queue.student15-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student15-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student15" {
  name = "student15"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student16-unsolved" {
    name = "student16-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student16-solved" {
    name = "student16-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student16-unsolved" {
    name = "${azurerm_servicebus_queue.student16-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student16-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student16-solved" {
    name = "${azurerm_servicebus_queue.student16-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student16-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student16" {
  name = "student16"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student17-unsolved" {
    name = "student17-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student17-solved" {
    name = "student17-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student17-unsolved" {
    name = "${azurerm_servicebus_queue.student17-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student17-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student17-solved" {
    name = "${azurerm_servicebus_queue.student17-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student17-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student17" {
  name = "student17"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student18-unsolved" {
    name = "student18-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student18-solved" {
    name = "student18-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student18-unsolved" {
    name = "${azurerm_servicebus_queue.student18-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student18-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student18-solved" {
    name = "${azurerm_servicebus_queue.student18-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student18-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student18" {
  name = "student18"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student19-unsolved" {
    name = "student19-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student19-solved" {
    name = "student19-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student19-unsolved" {
    name = "${azurerm_servicebus_queue.student19-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student19-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student19-solved" {
    name = "${azurerm_servicebus_queue.student19-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student19-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student19" {
  name = "student19"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student20-unsolved" {
    name = "student20-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student20-solved" {
    name = "student20-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student20-unsolved" {
    name = "${azurerm_servicebus_queue.student20-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student20-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student20-solved" {
    name = "${azurerm_servicebus_queue.student20-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student20-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student20" {
  name = "student20"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student21-unsolved" {
    name = "student21-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student21-solved" {
    name = "student21-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student21-unsolved" {
    name = "${azurerm_servicebus_queue.student21-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student21-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student21-solved" {
    name = "${azurerm_servicebus_queue.student21-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student21-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student21" {
  name = "student21"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student22-unsolved" {
    name = "student22-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student22-solved" {
    name = "student22-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student22-unsolved" {
    name = "${azurerm_servicebus_queue.student22-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student22-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student22-solved" {
    name = "${azurerm_servicebus_queue.student22-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student22-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student22" {
  name = "student22"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student23-unsolved" {
    name = "student23-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student23-solved" {
    name = "student23-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student23-unsolved" {
    name = "${azurerm_servicebus_queue.student23-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student23-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student23-solved" {
    name = "${azurerm_servicebus_queue.student23-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student23-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student23" {
  name = "student23"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student24-unsolved" {
    name = "student24-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student24-solved" {
    name = "student24-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student24-unsolved" {
    name = "${azurerm_servicebus_queue.student24-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student24-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student24-solved" {
    name = "${azurerm_servicebus_queue.student24-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student24-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student24" {
  name = "student24"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student25-unsolved" {
    name = "student25-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student25-solved" {
    name = "student25-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student25-unsolved" {
    name = "${azurerm_servicebus_queue.student25-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student25-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student25-solved" {
    name = "${azurerm_servicebus_queue.student25-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student25-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student25" {
  name = "student25"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student26-unsolved" {
    name = "student26-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student26-solved" {
    name = "student26-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student26-unsolved" {
    name = "${azurerm_servicebus_queue.student26-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student26-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student26-solved" {
    name = "${azurerm_servicebus_queue.student26-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student26-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student26" {
  name = "student26"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student27-unsolved" {
    name = "student27-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student27-solved" {
    name = "student27-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student27-unsolved" {
    name = "${azurerm_servicebus_queue.student27-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student27-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student27-solved" {
    name = "${azurerm_servicebus_queue.student27-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student27-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student27" {
  name = "student27"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student28-unsolved" {
    name = "student28-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student28-solved" {
    name = "student28-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student28-unsolved" {
    name = "${azurerm_servicebus_queue.student28-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student28-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student28-solved" {
    name = "${azurerm_servicebus_queue.student28-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student28-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student28" {
  name = "student28"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student29-unsolved" {
    name = "student29-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student29-solved" {
    name = "student29-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student29-unsolved" {
    name = "${azurerm_servicebus_queue.student29-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student29-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student29-solved" {
    name = "${azurerm_servicebus_queue.student29-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student29-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student29" {
  name = "student29"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student30-unsolved" {
    name = "student30-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student30-solved" {
    name = "student30-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student30-unsolved" {
    name = "${azurerm_servicebus_queue.student30-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student30-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student30-solved" {
    name = "${azurerm_servicebus_queue.student30-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student30-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student30" {
  name = "student30"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student31-unsolved" {
    name = "student31-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student31-solved" {
    name = "student31-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student31-unsolved" {
    name = "${azurerm_servicebus_queue.student31-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student31-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student31-solved" {
    name = "${azurerm_servicebus_queue.student31-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student31-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student31" {
  name = "student31"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student32-unsolved" {
    name = "student32-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student32-solved" {
    name = "student32-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student32-unsolved" {
    name = "${azurerm_servicebus_queue.student32-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student32-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student32-solved" {
    name = "${azurerm_servicebus_queue.student32-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student32-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student32" {
  name = "student32"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student33-unsolved" {
    name = "student33-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student33-solved" {
    name = "student33-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student33-unsolved" {
    name = "${azurerm_servicebus_queue.student33-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student33-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student33-solved" {
    name = "${azurerm_servicebus_queue.student33-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student33-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student33" {
  name = "student33"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student34-unsolved" {
    name = "student34-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student34-solved" {
    name = "student34-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student34-unsolved" {
    name = "${azurerm_servicebus_queue.student34-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student34-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student34-solved" {
    name = "${azurerm_servicebus_queue.student34-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student34-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student34" {
  name = "student34"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student35-unsolved" {
    name = "student35-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student35-solved" {
    name = "student35-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student35-unsolved" {
    name = "${azurerm_servicebus_queue.student35-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student35-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student35-solved" {
    name = "${azurerm_servicebus_queue.student35-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student35-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student35" {
  name = "student35"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student36-unsolved" {
    name = "student36-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student36-solved" {
    name = "student36-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student36-unsolved" {
    name = "${azurerm_servicebus_queue.student36-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student36-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student36-solved" {
    name = "${azurerm_servicebus_queue.student36-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student36-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student36" {
  name = "student36"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student37-unsolved" {
    name = "student37-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student37-solved" {
    name = "student37-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student37-unsolved" {
    name = "${azurerm_servicebus_queue.student37-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student37-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student37-solved" {
    name = "${azurerm_servicebus_queue.student37-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student37-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student37" {
  name = "student37"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student38-unsolved" {
    name = "student38-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student38-solved" {
    name = "student38-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student38-unsolved" {
    name = "${azurerm_servicebus_queue.student38-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student38-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student38-solved" {
    name = "${azurerm_servicebus_queue.student38-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student38-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student38" {
  name = "student38"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student39-unsolved" {
    name = "student39-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student39-solved" {
    name = "student39-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student39-unsolved" {
    name = "${azurerm_servicebus_queue.student39-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student39-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student39-solved" {
    name = "${azurerm_servicebus_queue.student39-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student39-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student39" {
  name = "student39"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student40-unsolved" {
    name = "student40-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student40-solved" {
    name = "student40-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student40-unsolved" {
    name = "${azurerm_servicebus_queue.student40-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student40-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student40-solved" {
    name = "${azurerm_servicebus_queue.student40-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student40-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student40" {
  name = "student40"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student41-unsolved" {
    name = "student41-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student41-solved" {
    name = "student41-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student41-unsolved" {
    name = "${azurerm_servicebus_queue.student41-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student41-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student41-solved" {
    name = "${azurerm_servicebus_queue.student41-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student41-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student41" {
  name = "student41"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student42-unsolved" {
    name = "student42-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student42-solved" {
    name = "student42-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student42-unsolved" {
    name = "${azurerm_servicebus_queue.student42-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student42-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student42-solved" {
    name = "${azurerm_servicebus_queue.student42-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student42-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student42" {
  name = "student42"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student43-unsolved" {
    name = "student43-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student43-solved" {
    name = "student43-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student43-unsolved" {
    name = "${azurerm_servicebus_queue.student43-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student43-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student43-solved" {
    name = "${azurerm_servicebus_queue.student43-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student43-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student43" {
  name = "student43"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student44-unsolved" {
    name = "student44-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student44-solved" {
    name = "student44-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student44-unsolved" {
    name = "${azurerm_servicebus_queue.student44-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student44-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student44-solved" {
    name = "${azurerm_servicebus_queue.student44-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student44-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student44" {
  name = "student44"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student45-unsolved" {
    name = "student45-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student45-solved" {
    name = "student45-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student45-unsolved" {
    name = "${azurerm_servicebus_queue.student45-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student45-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student45-solved" {
    name = "${azurerm_servicebus_queue.student45-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student45-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student45" {
  name = "student45"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student46-unsolved" {
    name = "student46-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student46-solved" {
    name = "student46-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student46-unsolved" {
    name = "${azurerm_servicebus_queue.student46-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student46-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student46-solved" {
    name = "${azurerm_servicebus_queue.student46-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student46-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student46" {
  name = "student46"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student47-unsolved" {
    name = "student47-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student47-solved" {
    name = "student47-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student47-unsolved" {
    name = "${azurerm_servicebus_queue.student47-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student47-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student47-solved" {
    name = "${azurerm_servicebus_queue.student47-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student47-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student47" {
  name = "student47"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student48-unsolved" {
    name = "student48-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student48-solved" {
    name = "student48-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student48-unsolved" {
    name = "${azurerm_servicebus_queue.student48-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student48-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student48-solved" {
    name = "${azurerm_servicebus_queue.student48-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student48-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student48" {
  name = "student48"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student49-unsolved" {
    name = "student49-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student49-solved" {
    name = "student49-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student49-unsolved" {
    name = "${azurerm_servicebus_queue.student49-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student49-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student49-solved" {
    name = "${azurerm_servicebus_queue.student49-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student49-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student49" {
  name = "student49"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student50-unsolved" {
    name = "student50-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student50-solved" {
    name = "student50-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student50-unsolved" {
    name = "${azurerm_servicebus_queue.student50-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student50-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student50-solved" {
    name = "${azurerm_servicebus_queue.student50-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student50-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student50" {
  name = "student50"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student51-unsolved" {
    name = "student51-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student51-solved" {
    name = "student51-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student51-unsolved" {
    name = "${azurerm_servicebus_queue.student51-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student51-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student51-solved" {
    name = "${azurerm_servicebus_queue.student51-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student51-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student51" {
  name = "student51"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student52-unsolved" {
    name = "student52-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student52-solved" {
    name = "student52-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student52-unsolved" {
    name = "${azurerm_servicebus_queue.student52-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student52-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student52-solved" {
    name = "${azurerm_servicebus_queue.student52-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student52-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student52" {
  name = "student52"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student53-unsolved" {
    name = "student53-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student53-solved" {
    name = "student53-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student53-unsolved" {
    name = "${azurerm_servicebus_queue.student53-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student53-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student53-solved" {
    name = "${azurerm_servicebus_queue.student53-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student53-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student53" {
  name = "student53"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student54-unsolved" {
    name = "student54-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student54-solved" {
    name = "student54-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student54-unsolved" {
    name = "${azurerm_servicebus_queue.student54-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student54-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student54-solved" {
    name = "${azurerm_servicebus_queue.student54-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student54-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student54" {
  name = "student54"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student55-unsolved" {
    name = "student55-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student55-solved" {
    name = "student55-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student55-unsolved" {
    name = "${azurerm_servicebus_queue.student55-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student55-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student55-solved" {
    name = "${azurerm_servicebus_queue.student55-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student55-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student55" {
  name = "student55"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student56-unsolved" {
    name = "student56-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student56-solved" {
    name = "student56-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student56-unsolved" {
    name = "${azurerm_servicebus_queue.student56-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student56-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student56-solved" {
    name = "${azurerm_servicebus_queue.student56-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student56-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student56" {
  name = "student56"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student57-unsolved" {
    name = "student57-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student57-solved" {
    name = "student57-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student57-unsolved" {
    name = "${azurerm_servicebus_queue.student57-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student57-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student57-solved" {
    name = "${azurerm_servicebus_queue.student57-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student57-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student57" {
  name = "student57"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student58-unsolved" {
    name = "student58-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student58-solved" {
    name = "student58-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student58-unsolved" {
    name = "${azurerm_servicebus_queue.student58-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student58-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student58-solved" {
    name = "${azurerm_servicebus_queue.student58-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student58-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student58" {
  name = "student58"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}


resource "azurerm_servicebus_queue" "student59-unsolved" {
    name = "student59-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student59-solved" {
    name = "student59-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student59-unsolved" {
    name = "${azurerm_servicebus_queue.student59-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student59-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "student59-solved" {
    name = "${azurerm_servicebus_queue.student59-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student59-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "student59" {
  name = "student59"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.random_puzzles.name}"
  max_delivery_count = 10
}

