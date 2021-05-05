locals {
  under_replicated_partitions_filter               = var.under_replicated_partitions_filter_override != "" ? var.under_replicated_partitions_filter_override : var.filter_str
  under_replicated_partitions_notification_channel = var.under_replicated_partitions_alerting_enabled ? var.notification_channel : ""
}

module "under_replicated_partitions" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.5.2"

  name             = "UnderReplicated Partitions"
  query            = "avg(${var.under_replicated_partitions_evaluation_period}):avg:kafka.replication.under_replicated_partitions{${local.under_replicated_partitions_filter}} by {aiven-service} > ${var.under_replicated_partitions_critical}"
  alert_message    = "Kafka cluster is not fully replicated."
  recovery_message = "Kafka cluster replication recovered"

  # monitor level vars
  enabled            = var.under_replicated_partitions_enabled
  alerting_enabled   = var.under_replicated_partitions_alerting_enabled
  critical_threshold = var.under_replicated_partitions_critical
  # warning_threshold  = var.under_replicated_partitions_warning
  priority           = var.under_replicated_partitions_priority
  severity           = var.under_replicated_partitions_severity
  docs               = var.under_replicated_partitions_docs
  note               = var.under_replicated_partitions_note
  require_full_window = var.under_replicated_partitions_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
