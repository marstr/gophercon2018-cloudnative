#!/usr/bin/perl

use strict;
use warnings;

my $header = <<'END_MESSAGE';
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

END_MESSAGE

my $rawStudent = <<'END_MESSAGE';
resource "azurerm_servicebus_queue" "STUDENT_ID" {
    name = "STUDENT_ID"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
}

resource "azurerm_servicebus_queue_authorization_rule" "STUDENT_ID" {
    name = "${azurerm_servicebus_queue.STUDENT_ID.name}"
    resource_group_name = "${azurerm_resource_group.gophercon2018.name}"
    namespace_name = "${azurerm_servicebus_namespace.gophercon2018.name}"
    queue_name = "${azurerm_servicebus_queue.STUDENT_ID.name}"
    listen = true
    send = true
    manage = false
}

END_MESSAGE

print $header;

for (my $i=0; $i < $ARGV[0]; $i++) {
    my $updatedStudent = $rawStudent;
    $updatedStudent =~ s/STUDENT_ID/student$i/mg;

    print $updatedStudent;
}