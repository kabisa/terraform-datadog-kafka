variable "offline_partitions_enabled" {
  type    = bool
  default = true
}

variable "offline_partitions_warning" {
  type    = number
  default = 0
}

variable "offline_partitions_critical" {
  type    = number
  default = 0
}

variable "offline_partitions_evaluation_period" {
  type    = string
  default = "last_5m"
}

variable "offline_partitions_severity" {
  type    = string
  default = "major"
}

variable "offline_partitions_note" {
  type    = string
  default = ""
}

variable "offline_partitions_docs" {
  type    = string
  default = <<EOFF
  This metric reports the number of partitions without an active leader. Because all read and write operations are only performed on partition leaders, you should alert on a non-zero value for this metric to prevent service interruptions. Any partition without an active leader will be completely inaccessible, and both consumers and producers of that partition will be blocked until a leader becomes available.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "offline_partitions_filter_override" {
  type    = string
  default = ""
}

variable "offline_partitions_alerting_enabled" {
  type    = bool
  default = true
}

variable "offline_partitions_require_full_window" {
  type = bool
  default = true
}

variable "offline_partitions_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}