variable "env" {
  type = string
}

variable "alert_env" {
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