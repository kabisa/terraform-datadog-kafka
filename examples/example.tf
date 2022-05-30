#module "kafka" {
#  source = "kabisa/kafka/datadog"
#
#  notification_channel       = "mail@example.com"
#  service                    = "ServiceX"
#  env                        = "prd"
#  filter_str                 = "service:kafka"
#  service_check_include_tags = ["service:kafka"]
#}
