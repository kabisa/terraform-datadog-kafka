locals {
  bytesout_high_filter               = var.bytesout_high_filter_override != "" ? var.bytesout_high_filter_override : var.filter_str
  bytesout_high_notification_channel = var.bytesout_high_alerting_enabled ? var.notification_channel : ""
}

module "bytesout_high" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name             = "BytesOut unusually high"
  query            = "avg(${var.bytesout_high_evaluation_period}):avg:kafka.net.bytes_out.rate{${local.bytesout_high_filter}} by {host} > ${var.bytesout_high_critical}"
  alert_message    = "Kafka is sending an unusual high network traffic"
  recovery_message = "Analyzed APM Spans have recovered"

  # monitor level vars
  enabled            = var.bytesout_high_enabled
  alerting_enabled   = var.bytesout_high_alerting_enabled
  critical_threshold = var.bytesout_high_critical
  warning_threshold  = var.bytesout_high_warning
  priority           = min(var.bytesout_high_priority + var.priority_offset, 5)
  docs               = var.bytesout_high_docs
  note               = var.bytesout_high_note

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
