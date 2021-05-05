variable "unusual_fetch_failures_enabled" {
  type    = bool
  default = true
}

variable "unusual_fetch_failures_warning" {
  type    = number
  default = 40
}

variable "unusual_fetch_failures_critical" {
  type    = number
  default = 50
}

variable "unusual_fetch_failures_evaluation_period" {
  type    = string
  default = "last_30m"
}

variable "unusual_fetch_failures_severity" {
  type    = string
  default = "minor"
}

variable "unusual_fetch_failures_note" {
  type    = string
  default = ""
}

variable "unusual_fetch_failures_docs" {
  type    = string
  default = <<EOFF
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task
  EOFF
}

variable "unusual_fetch_failures_filter_override" {
  type    = string
  default = "aiven-service:kafka-prod"
}

variable "unusual_fetch_failures_alerting_enabled" {
  type    = bool
  default = true
}

variable "unusual_fetch_failures_require_full_window" {
  type = bool
  default = true
}

variable "unusual_fetch_failures_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}