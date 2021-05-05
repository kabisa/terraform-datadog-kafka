locals {
  leader_election_occurring_filter               = var.leader_election_occurring_filter_override != "" ? var.leader_election_occurring_filter_override : var.filter_str
  leader_election_occurring_notification_channel = var.leader_election_occurring_alerting_enabled ? var.notification_channel : ""
}

module "leader_election_occurring" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.5.2"

  name             = "Leader Election occurring"
  query            = "max(${var.leader_election_occurring_evaluation_period}):avg:kafka.replication.leader_elections.rate{${local.leader_election_occurring_filter}} by {aiven-service} > ${var.leader_election_occurring_critical}"
  alert_message    = "Kafka is electing leaders"
  recovery_message = ""

  # monitor level vars
  enabled            = var.leader_election_occurring_enabled
  alerting_enabled   = var.leader_election_occurring_alerting_enabled
  critical_threshold = var.leader_election_occurring_critical
  # warning_threshold  = var.leader_election_occurring_warning
  priority           = var.leader_election_occurring_priority
  severity           = var.leader_election_occurring_severity
  docs               = var.leader_election_occurring_docs
  note               = var.leader_election_occurring_note
  require_full_window = var.leader_election_occurring_require_full_window

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
}
