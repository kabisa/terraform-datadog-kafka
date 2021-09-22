variable "under_replicated_partitions_enabled" {
  type    = bool
  default = true
}

variable "under_replicated_partitions_warning" {
  type    = number
  default = 100
}

variable "under_replicated_partitions_critical" {
  type    = number
  default = 0
}

variable "under_replicated_partitions_evaluation_period" {
  type    = string
  default = "last_15m"
}

variable "under_replicated_partitions_note" {
  type    = string
  default = ""
}

variable "under_replicated_partitions_docs" {
  type    = string
  default = <<EOFF
  If a broker becomes unavailable, the value of UnderReplicatedPartitions will increase sharply. Since Kafka’s high-availability guarantees cannot be met without replication, investigation is certainly warranted should this metric value exceed zero for extended time periods.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "under_replicated_partitions_filter_override" {
  type    = string
  default = ""
}

variable "under_replicated_partitions_alerting_enabled" {
  type    = bool
  default = true
}

variable "under_replicated_partitions_require_full_window" {
  type    = bool
  default = true
}

variable "under_replicated_partitions_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}