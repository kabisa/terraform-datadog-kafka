locals {
  unusual_produce_failures_filter               = var.unusual_produce_failures_filter_override != "" ? var.unusual_produce_failures_filter_override : var.filter_str
  unusual_produce_failures_notification_channel = var.unusual_produce_failures_alerting_enabled ? var.notification_channel : ""
}

module "unusual_produce_failures" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name             = "Unusual Produce Failures"
  query            = "avg(${var.unusual_produce_failures_evaluation_period}):avg:kafka.request.produce.failed.rate{${local.unusual_produce_failures_filter}} > ${var.unusual_produce_failures_critical}"
  alert_message    = ""
  recovery_message = ""

  # monitor level vars
  enabled             = var.unusual_produce_failures_enabled
  alerting_enabled    = var.unusual_produce_failures_alerting_enabled
  critical_threshold  = var.unusual_produce_failures_critical
  warning_threshold   = var.unusual_produce_failures_warning
  priority            = min(var.unusual_produce_failures_priority + var.priority_offset, 5)
  docs                = var.unusual_produce_failures_docs
  note                = var.unusual_produce_failures_note
  require_full_window = var.unusual_produce_failures_require_full_window

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
