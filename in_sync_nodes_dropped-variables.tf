variable "in_sync_nodes_dropped_enabled" {
  type    = bool
  default = true
}

variable "in_sync_nodes_dropped_warning" {
  type    = number
  default = 0
}

variable "in_sync_nodes_dropped_critical" {
  type    = number
  default = 0
}

variable "in_sync_nodes_dropped_evaluation_period" {
  type    = string
  default = "last_5m"
}

variable "in_sync_nodes_dropped_severity" {
  type    = string
  default = "major"
}

variable "in_sync_nodes_dropped_note" {
  type    = string
  default = ""
}

variable "in_sync_nodes_dropped_docs" {
  type    = string
  default = <<EOFF
  The number of in-sync replicas (ISRs) for a particular partition should remain fairly static, except when you are expanding your broker cluster or removing partitions. In order to maintain high availability, a healthy Kafka cluster requires a minimum number of ISRs for failover. A replica could be removed from the ISR pool if it has not contacted the leader for some time (configurable with the replica.socket.timeout.ms parameter). You should investigate any flapping in the values of these metrics, and any increase in IsrShrinksPerSec without a corresponding increase in IsrExpandsPerSec shortly thereafter.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "in_sync_nodes_dropped_filter_override" {
  type    = string
  default = ""
}

variable "in_sync_nodes_dropped_alerting_enabled" {
  type    = bool
  default = true
}

variable "in_sync_nodes_dropped_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}