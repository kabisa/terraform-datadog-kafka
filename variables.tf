variable "env" {
  type = string
}

variable "service" {
  type    = string
  default = "Kafka"
}

variable "notification_channel" {
  type = string
}

variable "additional_tags" {
  type    = list(string)
  default = []
}

variable "filter_str" {
  type = string
}

variable "is_hosted_service" {
  type    = bool
  default = false
}

variable "locked" {
  type    = bool
  default = true
}

variable "system_notification_channel_override" {
  type    = string
  default = null
}

variable "name_prefix" {
  description = "Can be used to prefix to the Monitor name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Can be used to suffix to the Monitor name"
  type        = string
  default     = ""
}

variable "priority_offset" {
  description = "For non production workloads we can +1 on the priorities"
  default     = 0
}
