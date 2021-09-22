locals {
  in_sync_nodes_dropped_filter               = var.in_sync_nodes_dropped_filter_override != "" ? var.in_sync_nodes_dropped_filter_override : var.filter_str
  in_sync_nodes_dropped_notification_channel = var.in_sync_nodes_dropped_alerting_enabled ? var.notification_channel : ""
}

module "in_sync_nodes_dropped" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name             = "In Sync Nodes dropped"
  query            = "avg(${var.in_sync_nodes_dropped_evaluation_period}):max:kafka.replication.isr_shrinks.rate{${local.in_sync_nodes_dropped_filter}} by {aiven-service} - max:kafka.replication.isr_expands.rate{${local.in_sync_nodes_dropped_filter}} by {aiven-service} > ${var.in_sync_nodes_dropped_critical}"
  alert_message    = "The number of in Sync Nodes dropped compared to the number of In Sync Nodes that were added"
  recovery_message = ""

  # monitor level vars
  enabled            = var.in_sync_nodes_dropped_enabled
  alerting_enabled   = var.in_sync_nodes_dropped_alerting_enabled
  critical_threshold = var.in_sync_nodes_dropped_critical
  # warning_threshold  = var.in_sync_nodes_dropped_warning
  priority = var.in_sync_nodes_dropped_priority
  docs     = var.in_sync_nodes_dropped_docs
  note     = var.in_sync_nodes_dropped_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
