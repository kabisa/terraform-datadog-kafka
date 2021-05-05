variable "produce_purgatory_size_enabled" {
  type    = bool
  default = true
}

variable "produce_purgatory_size_warning" {
  type    = number
  default = 100
}

variable "produce_purgatory_size_critical" {
  type    = number
  default = 200
}

variable "produce_purgatory_size_evaluation_period" {
  type    = string
  default = "last_15m"
}

variable "produce_purgatory_size_severity" {
  type    = string
  default = "minor"
}

variable "produce_purgatory_size_note" {
  type    = string
  default = ""
}

variable "produce_purgatory_size_docs" {
  type    = string
  default = <<EOFF
  The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  If request.required.acks=-1, all produce requests will end up in purgatory until the partition leader receives an acknowledgment from all followers.

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "produce_purgatory_size_filter_override" {
  type    = string
  default = ""
}

variable "produce_purgatory_size_alerting_enabled" {
  type    = bool
  default = true
}

variable "produce_purgatory_size_require_full_window" {
  type = bool
  default = true
}

variable "produce_purgatory_size_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}