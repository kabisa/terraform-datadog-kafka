variable "bytesout_high_enabled" {
  type    = bool
  default = true
}

variable "bytesout_high_warning" {
  type    = number
  default = 2500000
}

variable "bytesout_high_critical" {
  type    = number
  default = 5000000
}

variable "bytesout_high_evaluation_period" {
  type    = string
  default = "last_30m"
}

variable "bytesout_high_severity" {
  type    = string
  default = "minor"
}

variable "bytesout_high_note" {
  type    = string
  default = ""
}

variable "bytesout_high_docs" {
  type    = string
  default = <<EOFF
  NOTE: This is based on a baseline and might need adjusting further down the road.

  Generally, disk throughput tends to be the main bottleneck in Kafka performance. However, that’s not to say that the network is never a bottleneck. Network throughput can affect Kafka’s performance if you are sending messages across data centers, if your topics have a large number of consumers, or if your replicas are catching up to their leaders. Tracking network throughput on your brokers gives you more information as to where potential bottlenecks may lie, and can inform decisions like whether or not you should enable end-to-end compression of your messages.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "bytesout_high_filter_override" {
  type    = string
  default = ""
}

variable "bytesout_high_alerting_enabled" {
  type    = bool
  default = true
}

variable "bytesout_high_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = null
}