locals {
  produce_purgatory_size_filter               = var.produce_purgatory_size_filter_override != "" ? var.produce_purgatory_size_filter_override : var.filter_str
  produce_purgatory_size_notification_channel = var.produce_purgatory_size_alerting_enabled ? var.notification_channel : ""
}

module "produce_purgatory_size" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.5.2"

  name             = "Produce Purgatory Size"
  query            = "avg(${var.produce_purgatory_size_evaluation_period}):max:kafka.request.producer_request_purgatory.size{${local.produce_purgatory_size_filter}} > ${var.produce_purgatory_size_critical}"
  alert_message    = "Purgatory size ({{value}}) larger than usual."
  recovery_message = "Purgatory size ({{values}} recovered"

  # monitor level vars
  enabled            = var.produce_purgatory_size_enabled
  alerting_enabled   = var.produce_purgatory_size_alerting_enabled
  critical_threshold = var.produce_purgatory_size_critical
  warning_threshold  = var.produce_purgatory_size_warning
  priority           = var.produce_purgatory_size_priority
  severity           = var.produce_purgatory_size_severity
  docs               = var.produce_purgatory_size_docs
  note               = var.produce_purgatory_size_note
  require_full_window = var.produce_purgatory_size_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
