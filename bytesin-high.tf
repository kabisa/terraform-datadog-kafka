locals {
  bytesin_high_filter               = var.bytesin_high_filter_override != "" ? var.bytesin_high_filter_override : var.filter_str
  bytesin_high_notification_channel = var.bytesin_high_alerting_enabled ? var.notification_channel : ""
}

module "bytesin_high" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name             = "BytesIn unusually high"
  query            = "avg(${var.bytesin_high_evaluation_period}):avg:kafka.net.bytes_in.rate{${local.bytesin_high_filter}} by {host} > ${var.bytesin_high_critical}"
  alert_message    = "The Plan specified {{threshold}} APM Analyzed Spans. The current estimate ({{value}}) exceeds the plan"
  recovery_message = "Analyzed APM Spans have recovered"

  # monitor level vars
  enabled            = var.bytesin_high_enabled
  alerting_enabled   = var.bytesin_high_alerting_enabled
  critical_threshold = var.bytesin_high_critical
  warning_threshold  = var.bytesin_high_warning
  priority           = min(var.bytesin_high_priority + var.priority_offset, 5)
  docs               = var.bytesin_high_docs
  note               = var.bytesin_high_note

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
