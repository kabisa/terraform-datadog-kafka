locals {
  no_active_controllers_filter               = var.no_active_controllers_filter_override != "" ? var.no_active_controllers_filter_override : var.filter_str
  no_active_controllers_notification_channel = var.no_active_controllers_alerting_enabled ? var.notification_channel : ""
}

module "no_active_controllers" {
  source  = "kabisa/generic-monitor/datadog"
  version = "0.7.5"

  name             = "No Active controllers"
  query            = "avg(${var.no_active_controllers_evaluation_period}):max:kafka.replication.active_controller_count{${local.no_active_controllers_filter}} by {aiven-project} < ${var.no_active_controllers_critical}"
  alert_message    = "No active Kafka controllers. There should be one and only one."
  recovery_message = "Kafka controller count recovered"

  # monitor level vars
  enabled            = var.no_active_controllers_enabled
  alerting_enabled   = var.no_active_controllers_alerting_enabled
  critical_threshold = var.no_active_controllers_critical
  # warning_threshold  = var.no_active_controllers_warning
  priority            = min(var.no_active_controllers_priority + var.priority_offset, 5)
  docs                = var.no_active_controllers_docs
  note                = var.no_active_controllers_note
  require_full_window = var.no_active_controllers_require_full_window

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
