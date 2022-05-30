variable "unclean_leader_election_enabled" {
  type    = bool
  default = true
}

variable "unclean_leader_election_warning" {
  type    = number
  default = 100
}

variable "unclean_leader_election_critical" {
  type    = number
  default = 0
}

variable "unclean_leader_election_evaluation_period" {
  type    = string
  default = "last_5m"
}

variable "unclean_leader_election_note" {
  type    = string
  default = ""
}

variable "unclean_leader_election_docs" {
  type    = string
  default = <<EOFF
  Unclean leader elections occur when there is no qualified partition leader among Kafka brokers. Normally, when a broker that is the leader for a partition goes offline, a new leader is elected from the set of ISRs for the partition. Unclean leader election is disabled by default in Kafka version 0.11 and newer, meaning that a partition is taken offline if it does not have any ISRs to elect as the new leader. If Kafka is configured to allow an unclean leader election, a leader is chosen from the out-of-sync replicas, and any messages that were not synced prior to the loss of the former leader are lost forever. Essentially, unclean leader elections sacrifice consistency for availability. You should alert on this metric, as it signals data loss.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "unclean_leader_election_filter_override" {
  type    = string
  default = ""
}

variable "unclean_leader_election_alerting_enabled" {
  type    = bool
  default = true
}

variable "unclean_leader_election_require_full_window" {
  type    = bool
  default = false
}

variable "unclean_leader_election_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 2
}
