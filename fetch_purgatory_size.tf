locals {
  fetch_purgatory_size_filter               = var.fetch_purgatory_size_filter_override != "" ? var.fetch_purgatory_size_filter_override : var.filter_str
  fetch_purgatory_size_notification_channel = var.fetch_purgatory_size_alerting_enabled ? var.notification_channel : ""
}

module "fetch_purgatory_size" {
  source  = "kabisa/generic-monitor/datadog"
  version = "0.7.5"

  name             = "Fetch Purgatory Size"
  query            = "avg(${var.fetch_purgatory_size_evaluation_period}):max:kafka.request.fetch_request_purgatory.size{${local.fetch_purgatory_size_filter}} by {host} > ${var.fetch_purgatory_size_critical}"
  alert_message    = "Purgatory size ({{value}}) larger than usual."
  recovery_message = "Purgatory size ({{values}} recovered"

  # monitor level vars
  enabled            = var.fetch_purgatory_size_enabled
  alerting_enabled   = var.fetch_purgatory_size_alerting_enabled
  critical_threshold = var.fetch_purgatory_size_critical
  warning_threshold  = var.fetch_purgatory_size_warning
  priority           = min(var.fetch_purgatory_size_priority + var.priority_offset, 5)
  docs               = var.fetch_purgatory_size_docs
  note               = var.fetch_purgatory_size_note

  # module level vars
  env                  = var.env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
