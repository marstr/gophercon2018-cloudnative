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

resource "azurerm_servicebus_topic" "random_ids" {
    name = "random_ids"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "student0" {
    name = "student0"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student0" {
    name = "${azurerm_servicebus_queue.student0.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student0.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student1" {
    name = "student1"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student1" {
    name = "${azurerm_servicebus_queue.student1.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student1.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student2" {
    name = "student2"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student2" {
    name = "${azurerm_servicebus_queue.student2.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student2.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student3" {
    name = "student3"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student3" {
    name = "${azurerm_servicebus_queue.student3.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student3.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student4" {
    name = "student4"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student4" {
    name = "${azurerm_servicebus_queue.student4.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student4.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student5" {
    name = "student5"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student5" {
    name = "${azurerm_servicebus_queue.student5.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student5.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student6" {
    name = "student6"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student6" {
    name = "${azurerm_servicebus_queue.student6.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student6.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student7" {
    name = "student7"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student7" {
    name = "${azurerm_servicebus_queue.student7.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student7.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student8" {
    name = "student8"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student8" {
    name = "${azurerm_servicebus_queue.student8.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student8.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student9" {
    name = "student9"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student9" {
    name = "${azurerm_servicebus_queue.student9.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student9.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student10" {
    name = "student10"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student10" {
    name = "${azurerm_servicebus_queue.student10.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student10.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student11" {
    name = "student11"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student11" {
    name = "${azurerm_servicebus_queue.student11.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student11.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student12" {
    name = "student12"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student12" {
    name = "${azurerm_servicebus_queue.student12.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student12.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student13" {
    name = "student13"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student13" {
    name = "${azurerm_servicebus_queue.student13.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student13.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student14" {
    name = "student14"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student14" {
    name = "${azurerm_servicebus_queue.student14.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student14.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student15" {
    name = "student15"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student15" {
    name = "${azurerm_servicebus_queue.student15.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student15.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student16" {
    name = "student16"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student16" {
    name = "${azurerm_servicebus_queue.student16.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student16.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student17" {
    name = "student17"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student17" {
    name = "${azurerm_servicebus_queue.student17.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student17.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student18" {
    name = "student18"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student18" {
    name = "${azurerm_servicebus_queue.student18.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student18.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student19" {
    name = "student19"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student19" {
    name = "${azurerm_servicebus_queue.student19.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student19.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student20" {
    name = "student20"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student20" {
    name = "${azurerm_servicebus_queue.student20.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student20.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student21" {
    name = "student21"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student21" {
    name = "${azurerm_servicebus_queue.student21.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student21.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student22" {
    name = "student22"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student22" {
    name = "${azurerm_servicebus_queue.student22.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student22.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student23" {
    name = "student23"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student23" {
    name = "${azurerm_servicebus_queue.student23.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student23.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student24" {
    name = "student24"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student24" {
    name = "${azurerm_servicebus_queue.student24.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student24.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student25" {
    name = "student25"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student25" {
    name = "${azurerm_servicebus_queue.student25.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student25.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student26" {
    name = "student26"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student26" {
    name = "${azurerm_servicebus_queue.student26.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student26.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student27" {
    name = "student27"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student27" {
    name = "${azurerm_servicebus_queue.student27.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student27.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student28" {
    name = "student28"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student28" {
    name = "${azurerm_servicebus_queue.student28.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student28.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student29" {
    name = "student29"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student29" {
    name = "${azurerm_servicebus_queue.student29.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student29.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student30" {
    name = "student30"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student30" {
    name = "${azurerm_servicebus_queue.student30.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student30.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student31" {
    name = "student31"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student31" {
    name = "${azurerm_servicebus_queue.student31.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student31.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student32" {
    name = "student32"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student32" {
    name = "${azurerm_servicebus_queue.student32.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student32.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student33" {
    name = "student33"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student33" {
    name = "${azurerm_servicebus_queue.student33.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student33.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student34" {
    name = "student34"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student34" {
    name = "${azurerm_servicebus_queue.student34.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student34.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student35" {
    name = "student35"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student35" {
    name = "${azurerm_servicebus_queue.student35.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student35.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student36" {
    name = "student36"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student36" {
    name = "${azurerm_servicebus_queue.student36.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student36.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student37" {
    name = "student37"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student37" {
    name = "${azurerm_servicebus_queue.student37.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student37.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student38" {
    name = "student38"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student38" {
    name = "${azurerm_servicebus_queue.student38.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student38.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student39" {
    name = "student39"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student39" {
    name = "${azurerm_servicebus_queue.student39.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student39.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student40" {
    name = "student40"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student40" {
    name = "${azurerm_servicebus_queue.student40.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student40.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student41" {
    name = "student41"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student41" {
    name = "${azurerm_servicebus_queue.student41.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student41.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student42" {
    name = "student42"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student42" {
    name = "${azurerm_servicebus_queue.student42.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student42.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student43" {
    name = "student43"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student43" {
    name = "${azurerm_servicebus_queue.student43.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student43.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student44" {
    name = "student44"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student44" {
    name = "${azurerm_servicebus_queue.student44.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student44.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student45" {
    name = "student45"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student45" {
    name = "${azurerm_servicebus_queue.student45.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student45.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student46" {
    name = "student46"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student46" {
    name = "${azurerm_servicebus_queue.student46.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student46.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student47" {
    name = "student47"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student47" {
    name = "${azurerm_servicebus_queue.student47.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student47.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student48" {
    name = "student48"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student48" {
    name = "${azurerm_servicebus_queue.student48.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student48.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student49" {
    name = "student49"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student49" {
    name = "${azurerm_servicebus_queue.student49.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student49.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student50" {
    name = "student50"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student50" {
    name = "${azurerm_servicebus_queue.student50.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student50.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student51" {
    name = "student51"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student51" {
    name = "${azurerm_servicebus_queue.student51.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student51.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student52" {
    name = "student52"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student52" {
    name = "${azurerm_servicebus_queue.student52.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student52.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student53" {
    name = "student53"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student53" {
    name = "${azurerm_servicebus_queue.student53.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student53.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student54" {
    name = "student54"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student54" {
    name = "${azurerm_servicebus_queue.student54.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student54.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student55" {
    name = "student55"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student55" {
    name = "${azurerm_servicebus_queue.student55.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student55.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student56" {
    name = "student56"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student56" {
    name = "${azurerm_servicebus_queue.student56.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student56.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student57" {
    name = "student57"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student57" {
    name = "${azurerm_servicebus_queue.student57.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student57.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student58" {
    name = "student58"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student58" {
    name = "${azurerm_servicebus_queue.student58.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student58.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue" "student59" {
    name = "student59"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "student59" {
    name = "${azurerm_servicebus_queue.student59.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.student59.name}"
    listen = true
    send = true
    manage = false
}

