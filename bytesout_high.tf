locals {
  bytesout_high_filter               = var.bytesout_high_filter_override != "" ? var.bytesout_high_filter_override : var.filter_str
  bytesout_high_notification_channel = var.bytesout_high_alerting_enabled ? var.notification_channel : ""
}

module "bytesout_high" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.5.2"

  name             = "BytesOut unusually high"
  query            = "avg(${var.bytesout_high_evaluation_period}):avg:kafka.net.bytes_out.rate{${local.bytesout_high_filter}} by {host} > ${var.bytesout_high_critical}"
  alert_message    = "Kafka is sending an unusual high network traffic"
  recovery_message = "Analyzed APM Spans have recovered"

  # monitor level vars
  enabled            = var.bytesout_high_enabled
  alerting_enabled   = var.bytesout_high_alerting_enabled
  critical_threshold = var.bytesout_high_critical
  warning_threshold  = var.bytesout_high_warning
  priority           = var.bytesout_high_priority
  severity           = var.bytesout_high_severity
  docs               = var.bytesout_high_docs
  note               = var.bytesout_high_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
