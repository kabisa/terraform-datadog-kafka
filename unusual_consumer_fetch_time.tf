locals {
  unusual_consumer_fetch_time_filter               = var.unusual_consumer_fetch_time_filter_override != "" ? var.unusual_consumer_fetch_time_filter_override : var.filter_str
  unusual_consumer_fetch_time_notification_channel = var.unusual_consumer_fetch_time_alerting_enabled ? var.notification_channel : ""
}

module "unusual_consumer_fetch_time" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name             = "Unusual Consumer Fetch Time"
  query            = "avg(${var.unusual_consumer_fetch_time_evaluation_period}):avg:kafka.request.fetch_consumer.time.avg{${local.unusual_consumer_fetch_time_filter}} > ${var.unusual_consumer_fetch_time_critical}"
  alert_message    = ""
  recovery_message = ""

  # monitor level vars
  enabled             = var.unusual_consumer_fetch_time_enabled
  alerting_enabled    = var.unusual_consumer_fetch_time_alerting_enabled
  critical_threshold  = var.unusual_consumer_fetch_time_critical
  warning_threshold   = var.unusual_consumer_fetch_time_warning
  priority            = min(var.unusual_consumer_fetch_time_priority + var.priority_offset, 5)
  docs                = var.unusual_consumer_fetch_time_docs
  note                = var.unusual_consumer_fetch_time_note
  require_full_window = var.unusual_consumer_fetch_time_require_full_window

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
