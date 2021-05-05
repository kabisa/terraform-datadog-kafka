locals {
  offline_partitions_filter               = var.offline_partitions_filter_override != "" ? var.offline_partitions_filter_override : var.filter_str
  offline_partitions_notification_channel = var.offline_partitions_alerting_enabled ? var.notification_channel : ""
}

module "offline_partitions" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.5.2"

  name             = "Offline Partitions"
  query            = "avg(${var.offline_partitions_evaluation_period}):max:kafka.replication.offline_partitions_count{${local.offline_partitions_filter}} > ${var.offline_partitions_critical}"
  alert_message    = "Offline partitions detected {{value}}"
  recovery_message = "Kafka controller count recovered"

  # monitor level vars
  enabled            = var.offline_partitions_enabled
  alerting_enabled   = var.offline_partitions_alerting_enabled
  critical_threshold = var.offline_partitions_critical
  # warning_threshold  = var.offline_partitions_warning
  priority           = var.offline_partitions_priority
  severity           = var.offline_partitions_severity
  docs               = var.offline_partitions_docs
  note               = var.offline_partitions_note
  require_full_window = var.offline_partitions_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
