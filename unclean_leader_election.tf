locals {
  unclean_leader_election_filter               = var.unclean_leader_election_filter_override != "" ? var.unclean_leader_election_filter_override : var.filter_str
  unclean_leader_election_notification_channel = var.unclean_leader_election_alerting_enabled ? var.notification_channel : ""
}

module "unclean_leader_election" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name             = "Unclean Leader Election"
  query            = "avg(${var.unclean_leader_election_evaluation_period}):max:kafka.replication.unclean_leader_elections.rate{${local.unclean_leader_election_filter}} by {aiven-project} > ${var.unclean_leader_election_critical}"
  alert_message    = "Unclean Leader Election Detected"
  recovery_message = ""

  # monitor level vars
  enabled            = var.unclean_leader_election_enabled
  alerting_enabled   = var.unclean_leader_election_alerting_enabled
  critical_threshold = var.unclean_leader_election_critical
  # warning_threshold  = var.unclean_leader_election_warning
  priority            = var.unclean_leader_election_priority
  docs                = var.unclean_leader_election_docs
  note                = var.unclean_leader_election_note
  require_full_window = var.unclean_leader_election_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
