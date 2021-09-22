module "system" {
  source = "git@github.com:kabisa/terraform-datadog-system.git?ref=0.12.2"

  locked          = var.locked
  additional_tags = var.additional_tags
  alert_env       = var.alert_env
  env             = var.env
  filter_str      = var.filter_str

  notification_channel = var.system_notification_channel_override == null ? var.notification_channel : var.system_notification_channel_override


  service             = var.service
  bytes_sent_docs     = "If you are monitoring Kafka’s bytes in/out metric, you are getting Kafka’s side of the story. To get a full picture of network usage on your host, you need to monitor host-level network throughput, especially if your Kafka brokers are hosting other network services. High network usage could be a symptom of degraded performance—if you are seeing high network use, correlating with TCP retransmissions and dropped packet errors could help in determining if the performance issue is network-related.\nhttps://www.datadoghq.com/blog/monitoring-kafka-performance-metrics"
  bytes_received_docs = "If you are monitoring Kafka’s bytes in/out metric, you are getting Kafka’s side of the story. To get a full picture of network usage on your host, you need to monitor host-level network throughput, especially if your Kafka brokers are hosting other network services. High network usage could be a symptom of degraded performance—if you are seeing high network use, correlating with TCP retransmissions and dropped packet errors could help in determining if the performance issue is network-related.\nhttps://www.datadoghq.com/blog/monitoring-kafka-performance-metrics"

  # kafka uses nearly all memory
  memory_free_percent_enabled = false
  disk_free_percent_docs      = "Because Kafka persists all data to disk, it is necessary to monitor the amount of free disk space available to Kafka. Kafka will fail should its disk become full, so it’s very important that you keep track of disk growth over time, and set alerts to inform administrators at an appropriate amount of time before disk space is all but used up.\nhttps://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/"
  memory_free_bytes_enabled   = true
  memory_free_bytes_critical  = 30000000
  memory_free_bytes_warning   = 50000000
  # memory is a saw tooth chart (garbage collection cycles)
  memory_free_bytes_evaluation_period = "last_15m"

  # hosted service
  # we don't find everything as important as it's the job of the service
  # we do want to know what's going on so we downplay the severity
  dd_agent_enabled           = !var.is_hosted_service
  dd_agent_data_enabled      = !var.is_hosted_service
  reboot_enabled             = !var.is_hosted_service
  disk_free_percent_priority = var.is_hosted_service ? 3 : 2
  disk_io_wait_priority      = var.is_hosted_service ? 3 : 2
  memory_free_bytes_priority = var.is_hosted_service ? 3 : 2
}