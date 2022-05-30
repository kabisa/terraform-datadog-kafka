variable "multiple_active_controllers_enabled" {
  type    = bool
  default = true
}

variable "multiple_active_controllers_warning" {
  type    = number
  default = 0
}

variable "multiple_active_controllers_critical" {
  type    = number
  default = 1
}

variable "multiple_active_controllers_evaluation_period" {
  type    = string
  default = "last_5m"
}

variable "multiple_active_controllers_note" {
  type    = string
  default = ""
}

variable "multiple_active_controllers_docs" {
  type    = string
  default = <<EOFF
  The first node to boot in a Kafka cluster automatically becomes the controller, and there can be only one. The controller in a Kafka cluster is responsible for maintaining the list of partition leaders, and coordinating leadership transitions (in the event a partition leader becomes unavailable). If it becomes necessary to replace the controller, ZooKeeper chooses a new controller randomly from the pool of brokers. The sum of ActiveControllerCount across all of your brokers should always equal one, and you should alert on any other value that lasts for longer than one second.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/
  EOFF
}

variable "multiple_active_controllers_filter_override" {
  type    = string
  default = ""
}

variable "multiple_active_controllers_alerting_enabled" {
  type    = bool
  default = true
}

variable "multiple_active_controllers_require_full_window" {
  type    = bool
  default = true
}

variable "multiple_active_controllers_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 2
}
