locals {
  unusual_follower_fetch_time_filter               = var.unusual_follower_fetch_time_filter_override != "" ? var.unusual_follower_fetch_time_filter_override : var.filter_str
  unusual_follower_fetch_time_notification_channel = var.unusual_follower_fetch_time_alerting_enabled ? var.notification_channel : ""
}

module "unusual_follower_fetch_time" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name             = "Unusual Follower Fetch Time"
  query            = "avg(${var.unusual_follower_fetch_time_evaluation_period}):avg:kafka.request.fetch_follower.time.avg{${local.unusual_follower_fetch_time_filter}} > ${var.unusual_follower_fetch_time_critical}"
  alert_message    = "The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):"
  recovery_message = ""

  # monitor level vars
  enabled             = var.unusual_follower_fetch_time_enabled
  alerting_enabled    = var.unusual_follower_fetch_time_alerting_enabled
  critical_threshold  = var.unusual_follower_fetch_time_critical
  warning_threshold   = var.unusual_follower_fetch_time_warning
  priority            = var.unusual_follower_fetch_time_priority
  docs                = var.unusual_follower_fetch_time_docs
  note                = var.unusual_follower_fetch_time_note
  require_full_window = var.unusual_follower_fetch_time_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
