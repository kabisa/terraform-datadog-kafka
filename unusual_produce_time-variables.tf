variable "unusual_produce_time_enabled" {
  type    = bool
  default = true
}

variable "unusual_produce_time_warning" {
  type    = number
  default = 10
}

variable "unusual_produce_time_critical" {
  type    = number
  default = 20
}

variable "unusual_produce_time_evaluation_period" {
  type    = string
  default = "last_30m"
}

variable "unusual_produce_time_note" {
  type    = string
  default = ""
}

variable "unusual_produce_time_docs" {
  type    = string
  default = <<EOFF
  The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):
  
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task
  EOFF
}

variable "unusual_produce_time_filter_override" {
  type    = string
  default = ""
}

variable "unusual_produce_time_alerting_enabled" {
  type    = bool
  default = true
}

variable "unusual_produce_time_require_full_window" {
  type    = bool
  default = true
}

variable "unusual_produce_time_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}