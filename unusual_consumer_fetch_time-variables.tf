variable "unusual_consumer_fetch_time_enabled" {
  type    = bool
  default = true
}

variable "unusual_consumer_fetch_time_warning" {
  type    = number
  default = 800
}

variable "unusual_consumer_fetch_time_critical" {
  type    = number
  default = 1000
}

variable "unusual_consumer_fetch_time_evaluation_period" {
  type    = string
  default = "last_30m"
}

variable "unusual_consumer_fetch_time_severity" {
  type    = string
  default = "minor"
}

variable "unusual_consumer_fetch_time_note" {
  type    = string
  default = ""
}

variable "unusual_consumer_fetch_time_docs" {
  type    = string
  default = <<EOFF
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  EOFF
}

variable "unusual_consumer_fetch_time_filter_override" {
  type    = string
  default = ""
}

variable "unusual_consumer_fetch_time_alerting_enabled" {
  type    = bool
  default = true
}

variable "unusual_consumer_fetch_time_require_full_window" {
  type = bool
  default = true
}

variable "unusual_consumer_fetch_time_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}