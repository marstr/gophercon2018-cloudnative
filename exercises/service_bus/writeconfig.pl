#!/usr/bin/perl

use strict;
use warnings;

my $topicName = "random_puzzles";

my $rawHeader = <<'END_MESSAGE';
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

resource "azurerm_servicebus_topic" "TOPIC_NAME" {
    name = "TOPIC_NAME"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_topic_authorization_rule" "TOPIC_NAME" {
    name = "TOPIC_NAME"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    topic_name = "${azurerm_servicebus_topic.TOPIC_NAME.name}"
    listen = true
    send = false
    manage = false
}

END_MESSAGE

my $updatedHeader = $rawHeader;
$updatedHeader =~ s/TOPIC_NAME/$topicName/mg;

my $rawStudent = <<'END_MESSAGE';

resource "azurerm_servicebus_queue" "STUDENT_ID-unsolved" {
    name = "STUDENT_ID-unsolved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue" "STUDENT_ID-solved" {
    name = "STUDENT_ID-solved"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "STUDENT_ID-unsolved" {
    name = "${azurerm_servicebus_queue.STUDENT_ID-unsolved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.STUDENT_ID-unsolved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "STUDENT_ID-solved" {
    name = "${azurerm_servicebus_queue.STUDENT_ID-solved.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.STUDENT_ID-solved.name}"
    listen = true
    send = true
    manage = false
}

resource "azurerm_servicebus_subscription" "STUDENT_ID" {
  name = "STUDENT_ID"
  resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
  namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
  topic_name = "${azurerm_servicebus_topic.TOPIC_NAME.name}"
  max_delivery_count = 10
}

END_MESSAGE

print $updatedHeader;


my $studentCount = 60;

if (@ARGV > 0) {
    $studentCount = $ARGV[0];
}

for (my $i=0; $i < $studentCount; $i++) {
    my $updatedStudent = $rawStudent;
    $updatedStudent =~ s/STUDENT_ID/student$i/mg;
    $updatedStudent =~ s/TOPIC_NAME/$topicName/mg;

    print $updatedStudent;
}