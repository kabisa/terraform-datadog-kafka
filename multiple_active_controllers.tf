locals {
  multiple_active_controllers_filter               = var.multiple_active_controllers_filter_override != "" ? var.multiple_active_controllers_filter_override : var.filter_str
  multiple_active_controllers_notification_channel = var.multiple_active_controllers_alerting_enabled ? var.notification_channel : ""
}

module "multiple_active_controllers" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name             = "Multiple Active controllers"
  query            = "avg(${var.multiple_active_controllers_evaluation_period}):max:kafka.replication.active_controller_count{${local.multiple_active_controllers_filter}} by {aiven-project} > ${var.multiple_active_controllers_critical}"
  alert_message    = "Multiple active Kafka controllers. There should be one and only one."
  recovery_message = "Kafka controller count recovered"

  # monitor level vars
  enabled            = var.multiple_active_controllers_enabled
  alerting_enabled   = var.multiple_active_controllers_alerting_enabled
  critical_threshold = var.multiple_active_controllers_critical
  # warning_threshold  = var.multiple_active_controllers_warning
  priority            = var.multiple_active_controllers_priority
  docs                = var.multiple_active_controllers_docs
  note                = var.multiple_active_controllers_note
  require_full_window = var.multiple_active_controllers_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
