variable "fetch_purgatory_size_enabled" {
  type    = bool
  default = true
}

variable "fetch_purgatory_size_warning" {
  type    = number
  default = 70000
}

variable "fetch_purgatory_size_critical" {
  type    = number
  default = 100000
}

variable "fetch_purgatory_size_evaluation_period" {
  type    = string
  default = "last_30m"
}

variable "fetch_purgatory_size_note" {
  type    = string
  default = ""
}

variable "fetch_purgatory_size_docs" {
  type    = string
  default = <<EOFF
  The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  Fetch requests are added to purgatory if there is not enough data to fulfill the request (fetch.min.bytes on consumers) until the time specified by fetch.wait.max.ms is reached or enough data becomes available

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "fetch_purgatory_size_filter_override" {
  type    = string
  default = ""
}

variable "fetch_purgatory_size_alerting_enabled" {
  type    = bool
  default = true
}

variable "fetch_purgatory_size_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}