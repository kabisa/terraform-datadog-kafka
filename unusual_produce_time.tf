locals {
  unusual_produce_time_filter               = var.unusual_produce_time_filter_override != "" ? var.unusual_produce_time_filter_override : var.filter_str
  unusual_produce_time_notification_channel = var.unusual_produce_time_alerting_enabled ? var.notification_channel : ""
}

module "unusual_produce_time" {
  source  = "kabisa/generic-monitor/datadog"
  version = "0.7.5"

  name             = "Unusual Produce Time"
  query            = "avg(${var.unusual_produce_time_evaluation_period}):avg:kafka.request.produce.time.avg{${local.unusual_produce_time_filter}} > ${var.unusual_produce_time_critical}"
  alert_message    = ""
  recovery_message = ""

  # monitor level vars
  enabled             = var.unusual_produce_time_enabled
  alerting_enabled    = var.unusual_produce_time_alerting_enabled
  critical_threshold  = var.unusual_produce_time_critical
  warning_threshold   = var.unusual_produce_time_warning
  priority            = min(var.unusual_produce_time_priority + var.priority_offset, 5)
  docs                = var.unusual_produce_time_docs
  note                = var.unusual_produce_time_note
  require_full_window = var.unusual_produce_time_require_full_window

  # module level vars
  service              = var.service
  env                  = var.env
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
