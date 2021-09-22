variable "leader_election_occurring_enabled" {
  type    = bool
  default = true
}

variable "leader_election_occurring_warning" {
  type    = number
  default = 0
}

variable "leader_election_occurring_critical" {
  type    = number
  default = 0
}

variable "leader_election_occurring_evaluation_period" {
  type    = string
  default = "last_5m"
}

variable "leader_election_occurring_note" {
  type    = string
  default = ""
}

variable "leader_election_occurring_docs" {
  type    = string
  default = <<EOFF
  When a partition leader dies, an election for a new leader is triggered. A partition leader is considered “dead” if it fails to maintain its session with ZooKeeper. Unlike ZooKeeper’s Zab, Kafka does not employ a majority-consensus algorithm for leadership election. Instead, Kafka’s quorum is composed of the set of all in-sync replicas (ISRs) for a particular partition. Replicas are considered in-sync if they are caught-up to the leader, which means that any replica in the ISR can be promoted to the leader. 
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "leader_election_occurring_filter_override" {
  type    = string
  default = ""
}

variable "leader_election_occurring_alerting_enabled" {
  type    = bool
  default = true
}

variable "leader_election_occurring_require_full_window" {
  type    = bool
  default = false
}

variable "leader_election_occurring_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}