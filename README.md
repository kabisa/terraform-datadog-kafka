
![Datadog](https://imgix.datadoghq.com/img/about/presskit/logo-v/dd_vertical_purple.png)

[//]: # (This file is generated. Do not edit, module description can be added by editing / creating module_description.md)

# Terraform module for Datadog Kafka

This module contains both Kafka specific monitors and system monitors from our system module.

This module is part of a larger suite of modules that provide alerts in Datadog.
Other modules can be found on the [Terraform Registry](https://registry.terraform.io/search/modules?namespace=kabisa&provider=datadog)

We have two base modules we use to standardise development of our Monitor Modules:
- [generic monitor](https://github.com/kabisa/terraform-datadog-generic-monitor) Used in 90% of our alerts
- [service check monitor](https://github.com/kabisa/terraform-datadog-service-check-monitor)

Modules are generated with this tool: https://github.com/kabisa/datadog-terraform-generator

# Example Usage

```terraform
module "kafka" {
  source = "kabisa/kafka/datadog"

  notification_channel = "mail@example.com"
  service              = "ServiceX"
  env                  = "prd"
  filter_str           = "service:kafka"
}

```


[Module Variables](#module-variables)

Monitors:

| Monitor name    | Default enabled | Priority | Query                  |
|-----------------|------|----|------------------------|
| [Bytesin High](#bytesin-high) | True | 3  | `avg(last_30m):avg:kafka.net.bytes_in.rate{tag:xxx} by {host} > 5000000` |
| [Bytesout_high](#bytesout_high) | True | 3  | `avg(last_30m):avg:kafka.net.bytes_out.rate{tag:xxx} by {host} > 5000000` |
| [Fetch_purgatory_size](#fetch_purgatory_size) | True | 3  | `avg(last_30m):max:kafka.request.fetch_request_purgatory.size{tag:xxx} by {host} > 100000` |
| [In_sync_nodes_dropped](#in_sync_nodes_dropped) | True | 2  | `avg(last_5m):max:kafka.replication.isr_shrinks.rate{tag:xxx} by {aiven-service} - max:kafka.replication.isr_expands.rate{tag:xxx} by {aiven-service} > ` |
| [Leader_election_occurring](#leader_election_occurring) | True | 3  | `max(last_5m):avg:kafka.replication.leader_elections.rate{tag:xxx} by {aiven-service} > ` |
| [Multiple_active_controllers](#multiple_active_controllers) | True | 2  | `avg(last_5m):max:kafka.replication.active_controller_count{tag:xxx} by {aiven-project} > 1` |
| [No_active_controllers](#no_active_controllers) | True | 2  | `avg(last_5m):max:kafka.replication.active_controller_count{tag:xxx} by {aiven-project} < 1` |
| [Offline_partitions](#offline_partitions) | True | 2  | `avg(last_5m):max:kafka.replication.offline_partitions_count{tag:xxx} > ` |
| [Produce_purgatory_size](#produce_purgatory_size) | True | 3  | `avg(last_15m):max:kafka.request.producer_request_purgatory.size{tag:xxx} > 200` |
| [Unclean_leader_election](#unclean_leader_election) | True | 2  | `avg(last_5m):max:kafka.replication.unclean_leader_elections.rate{tag:xxx} by {aiven-project} > ` |
| [Under_replicated_partitions](#under_replicated_partitions) | True | 3  | `avg(last_15m):avg:kafka.replication.under_replicated_partitions{tag:xxx} by {aiven-service} > ` |
| [Unusual_consumer_fetch_time](#unusual_consumer_fetch_time) | True | 3  | `avg(last_30m):avg:kafka.request.fetch_consumer.time.avg{tag:xxx} > 1000` |
| [Unusual_fetch_failures](#unusual_fetch_failures) | True | 3  | `avg(last_30m):avg:kafka.request.fetch.failed.rate{tag:xxx} > 50` |
| [Unusual_follower_fetch_time](#unusual_follower_fetch_time) | True | 3  | `avg(last_30m):avg:kafka.request.fetch_follower.time.avg{tag:xxx} > 1000` |
| [Unusual_produce_failures](#unusual_produce_failures) | True | 3  | `avg(last_30m):avg:kafka.request.produce.failed.rate{tag:xxx} > 50` |
| [Unusual_produce_time](#unusual_produce_time) | True | 3  | `avg(last_30m):avg:kafka.request.produce.time.avg{tag:xxx} > 20` |

# Getting started developing
[pre-commit](http://pre-commit.com/) was used to do Terraform linting and validating.

Steps:
   - Install [pre-commit](http://pre-commit.com/). E.g. `brew install pre-commit`.
   - Run `pre-commit install` in this repo. (Every time you clone a repo with pre-commit enabled you will need to run the pre-commit install command)
   - That’s it! Now every time you commit a code change (`.tf` file), the hooks in the `hooks:` config `.pre-commit-config.yaml` will execute.

## Bytesin High

  NOTE: This is based on a baseline and might need adjusting further down the road. 
                                        
  Generally, disk throughput tends to be the main bottleneck in Kafka performance. However, that’s not to say that the network is never a bottleneck. Network throughput can affect Kafka’s performance if you are sending messages across data centers, if your topics have a large number of consumers, or if your replicas are catching up to their leaders. Tracking network throughput on your brokers gives you more information as to where potential bottlenecks may lie, and can inform decisions like whether or not you should enable end-to-end compression of your messages.

  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_30m):avg:kafka.net.bytes_in.rate{tag:xxx} by {host} > 5000000
```

| variable                       | default                                  | required | description                      |
|--------------------------------|------------------------------------------|----------|----------------------------------|
| bytesin_high_enabled           | True                                     | No       |                                  |
| bytesin_high_warning           | 2500000                                  | No       |                                  |
| bytesin_high_critical          | 5000000                                  | No       |                                  |
| bytesin_high_evaluation_period | last_30m                                 | No       |                                  |
| bytesin_high_note              | ""                                       | No       |                                  |
| bytesin_high_docs              | NOTE: This is based on a baseline and might need adjusting further down the road. 
                                        
  Generally, disk throughput tends to be the main bottleneck in Kafka performance. However, that’s not to say that the network is never a bottleneck. Network throughput can affect Kafka’s performance if you are sending messages across data centers, if your topics have a large number of consumers, or if your replicas are catching up to their leaders. Tracking network throughput on your brokers gives you more information as to where potential bottlenecks may lie, and can inform decisions like whether or not you should enable end-to-end compression of your messages.

  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| bytesin_high_filter_override   | ""                                       | No       |                                  |
| bytesin_high_alerting_enabled  | True                                     | No       |                                  |
| bytesin_high_priority          | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Bytesout_high

  NOTE: This is based on a baseline and might need adjusting further down the road.

  Generally, disk throughput tends to be the main bottleneck in Kafka performance. However, that’s not to say that the network is never a bottleneck. Network throughput can affect Kafka’s performance if you are sending messages across data centers, if your topics have a large number of consumers, or if your replicas are catching up to their leaders. Tracking network throughput on your brokers gives you more information as to where potential bottlenecks may lie, and can inform decisions like whether or not you should enable end-to-end compression of your messages.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_30m):avg:kafka.net.bytes_out.rate{tag:xxx} by {host} > 5000000
```

| variable                        | default                                  | required | description                      |
|---------------------------------|------------------------------------------|----------|----------------------------------|
| bytesout_high_enabled           | True                                     | No       |                                  |
| bytesout_high_warning           | 2500000                                  | No       |                                  |
| bytesout_high_critical          | 5000000                                  | No       |                                  |
| bytesout_high_evaluation_period | last_30m                                 | No       |                                  |
| bytesout_high_note              | ""                                       | No       |                                  |
| bytesout_high_docs              | NOTE: This is based on a baseline and might need adjusting further down the road.

  Generally, disk throughput tends to be the main bottleneck in Kafka performance. However, that’s not to say that the network is never a bottleneck. Network throughput can affect Kafka’s performance if you are sending messages across data centers, if your topics have a large number of consumers, or if your replicas are catching up to their leaders. Tracking network throughput on your brokers gives you more information as to where potential bottlenecks may lie, and can inform decisions like whether or not you should enable end-to-end compression of your messages.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| bytesout_high_filter_override   | ""                                       | No       |                                  |
| bytesout_high_alerting_enabled  | True                                     | No       |                                  |
| bytesout_high_priority          | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Fetch_purgatory_size

  The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  Fetch requests are added to purgatory if there is not enough data to fulfill the request (fetch.min.bytes on consumers) until the time specified by fetch.wait.max.ms is reached or enough data becomes available

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_30m):max:kafka.request.fetch_request_purgatory.size{tag:xxx} by {host} > 100000
```

| variable                               | default                                  | required | description                      |
|----------------------------------------|------------------------------------------|----------|----------------------------------|
| fetch_purgatory_size_enabled           | True                                     | No       |                                  |
| fetch_purgatory_size_warning           | 70000                                    | No       |                                  |
| fetch_purgatory_size_critical          | 100000                                   | No       |                                  |
| fetch_purgatory_size_evaluation_period | last_30m                                 | No       |                                  |
| fetch_purgatory_size_note              | ""                                       | No       |                                  |
| fetch_purgatory_size_docs              | The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  Fetch requests are added to purgatory if there is not enough data to fulfill the request (fetch.min.bytes on consumers) until the time specified by fetch.wait.max.ms is reached or enough data becomes available

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| fetch_purgatory_size_filter_override   | ""                                       | No       |                                  |
| fetch_purgatory_size_alerting_enabled  | True                                     | No       |                                  |
| fetch_purgatory_size_priority          | 3                                        | No       | Number from 1 (high) to 5 (low). |


## In_sync_nodes_dropped

  The number of in-sync replicas (ISRs) for a particular partition should remain fairly static, except when you are expanding your broker cluster or removing partitions. In order to maintain high availability, a healthy Kafka cluster requires a minimum number of ISRs for failover. A replica could be removed from the ISR pool if it has not contacted the leader for some time (configurable with the replica.socket.timeout.ms parameter). You should investigate any flapping in the values of these metrics, and any increase in IsrShrinksPerSec without a corresponding increase in IsrExpandsPerSec shortly thereafter.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_5m):max:kafka.replication.isr_shrinks.rate{tag:xxx} by {aiven-service} - max:kafka.replication.isr_expands.rate{tag:xxx} by {aiven-service} > 
```

| variable                                | default                                  | required | description                      |
|-----------------------------------------|------------------------------------------|----------|----------------------------------|
| in_sync_nodes_dropped_enabled           | True                                     | No       |                                  |
| in_sync_nodes_dropped_warning           | 0                                        | No       |                                  |
| in_sync_nodes_dropped_critical          | 0                                        | No       |                                  |
| in_sync_nodes_dropped_evaluation_period | last_5m                                  | No       |                                  |
| in_sync_nodes_dropped_note              | ""                                       | No       |                                  |
| in_sync_nodes_dropped_docs              | The number of in-sync replicas (ISRs) for a particular partition should remain fairly static, except when you are expanding your broker cluster or removing partitions. In order to maintain high availability, a healthy Kafka cluster requires a minimum number of ISRs for failover. A replica could be removed from the ISR pool if it has not contacted the leader for some time (configurable with the replica.socket.timeout.ms parameter). You should investigate any flapping in the values of these metrics, and any increase in IsrShrinksPerSec without a corresponding increase in IsrExpandsPerSec shortly thereafter.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| in_sync_nodes_dropped_filter_override   | ""                                       | No       |                                  |
| in_sync_nodes_dropped_alerting_enabled  | True                                     | No       |                                  |
| in_sync_nodes_dropped_priority          | 2                                        | No       | Number from 1 (high) to 5 (low). |


## Leader_election_occurring

  When a partition leader dies, an election for a new leader is triggered. A partition leader is considered “dead” if it fails to maintain its session with ZooKeeper. Unlike ZooKeeper’s Zab, Kafka does not employ a majority-consensus algorithm for leadership election. Instead, Kafka’s quorum is composed of the set of all in-sync replicas (ISRs) for a particular partition. Replicas are considered in-sync if they are caught-up to the leader, which means that any replica in the ISR can be promoted to the leader. 
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
max(last_5m):avg:kafka.replication.leader_elections.rate{tag:xxx} by {aiven-service} > 
```

| variable                                      | default                                  | required | description                      |
|-----------------------------------------------|------------------------------------------|----------|----------------------------------|
| leader_election_occurring_enabled             | True                                     | No       |                                  |
| leader_election_occurring_warning             | 0                                        | No       |                                  |
| leader_election_occurring_critical            | 0                                        | No       |                                  |
| leader_election_occurring_evaluation_period   | last_5m                                  | No       |                                  |
| leader_election_occurring_note                | ""                                       | No       |                                  |
| leader_election_occurring_docs                | When a partition leader dies, an election for a new leader is triggered. A partition leader is considered “dead” if it fails to maintain its session with ZooKeeper. Unlike ZooKeeper’s Zab, Kafka does not employ a majority-consensus algorithm for leadership election. Instead, Kafka’s quorum is composed of the set of all in-sync replicas (ISRs) for a particular partition. Replicas are considered in-sync if they are caught-up to the leader, which means that any replica in the ISR can be promoted to the leader. 
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| leader_election_occurring_filter_override     | ""                                       | No       |                                  |
| leader_election_occurring_alerting_enabled    | True                                     | No       |                                  |
| leader_election_occurring_require_full_window | False                                    | No       |                                  |
| leader_election_occurring_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Multiple_active_controllers

  The first node to boot in a Kafka cluster automatically becomes the controller, and there can be only one. The controller in a Kafka cluster is responsible for maintaining the list of partition leaders, and coordinating leadership transitions (in the event a partition leader becomes unavailable). If it becomes necessary to replace the controller, ZooKeeper chooses a new controller randomly from the pool of brokers. The sum of ActiveControllerCount across all of your brokers should always equal one, and you should alert on any other value that lasts for longer than one second.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_5m):max:kafka.replication.active_controller_count{tag:xxx} by {aiven-project} > 1
```

| variable                                        | default                                  | required | description                      |
|-------------------------------------------------|------------------------------------------|----------|----------------------------------|
| multiple_active_controllers_enabled             | True                                     | No       |                                  |
| multiple_active_controllers_warning             | 0                                        | No       |                                  |
| multiple_active_controllers_critical            | 1                                        | No       |                                  |
| multiple_active_controllers_evaluation_period   | last_5m                                  | No       |                                  |
| multiple_active_controllers_note                | ""                                       | No       |                                  |
| multiple_active_controllers_docs                | The first node to boot in a Kafka cluster automatically becomes the controller, and there can be only one. The controller in a Kafka cluster is responsible for maintaining the list of partition leaders, and coordinating leadership transitions (in the event a partition leader becomes unavailable). If it becomes necessary to replace the controller, ZooKeeper chooses a new controller randomly from the pool of brokers. The sum of ActiveControllerCount across all of your brokers should always equal one, and you should alert on any other value that lasts for longer than one second.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| multiple_active_controllers_filter_override     | ""                                       | No       |                                  |
| multiple_active_controllers_alerting_enabled    | True                                     | No       |                                  |
| multiple_active_controllers_require_full_window | True                                     | No       |                                  |
| multiple_active_controllers_priority            | 2                                        | No       | Number from 1 (high) to 5 (low). |


## No_active_controllers

  The first node to boot in a Kafka cluster automatically becomes the controller, and there can be only one. The controller in a Kafka cluster is responsible for maintaining the list of partition leaders, and coordinating leadership transitions (in the event a partition leader becomes unavailable). If it becomes necessary to replace the controller, ZooKeeper chooses a new controller randomly from the pool of brokers. The sum of ActiveControllerCount across all of your brokers should always equal one, and you should alert on any other value that lasts for longer than one second.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_5m):max:kafka.replication.active_controller_count{tag:xxx} by {aiven-project} < 1
```

| variable                                  | default                                  | required | description                      |
|-------------------------------------------|------------------------------------------|----------|----------------------------------|
| no_active_controllers_enabled             | True                                     | No       |                                  |
| no_active_controllers_warning             | 0                                        | No       |                                  |
| no_active_controllers_critical            | 1                                        | No       |                                  |
| no_active_controllers_evaluation_period   | last_5m                                  | No       |                                  |
| no_active_controllers_note                | ""                                       | No       |                                  |
| no_active_controllers_docs                | The first node to boot in a Kafka cluster automatically becomes the controller, and there can be only one. The controller in a Kafka cluster is responsible for maintaining the list of partition leaders, and coordinating leadership transitions (in the event a partition leader becomes unavailable). If it becomes necessary to replace the controller, ZooKeeper chooses a new controller randomly from the pool of brokers. The sum of ActiveControllerCount across all of your brokers should always equal one, and you should alert on any other value that lasts for longer than one second.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| no_active_controllers_filter_override     | ""                                       | No       |                                  |
| no_active_controllers_alerting_enabled    | True                                     | No       |                                  |
| no_active_controllers_require_full_window | True                                     | No       |                                  |
| no_active_controllers_priority            | 2                                        | No       | Number from 1 (high) to 5 (low). |


## Offline_partitions

  This metric reports the number of partitions without an active leader. Because all read and write operations are only performed on partition leaders, you should alert on a non-zero value for this metric to prevent service interruptions. Any partition without an active leader will be completely inaccessible, and both consumers and producers of that partition will be blocked until a leader becomes available.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_5m):max:kafka.replication.offline_partitions_count{tag:xxx} > 
```

| variable                               | default                                  | required | description                      |
|----------------------------------------|------------------------------------------|----------|----------------------------------|
| offline_partitions_enabled             | True                                     | No       |                                  |
| offline_partitions_warning             | 0                                        | No       |                                  |
| offline_partitions_critical            | 0                                        | No       |                                  |
| offline_partitions_evaluation_period   | last_5m                                  | No       |                                  |
| offline_partitions_note                | ""                                       | No       |                                  |
| offline_partitions_docs                | This metric reports the number of partitions without an active leader. Because all read and write operations are only performed on partition leaders, you should alert on a non-zero value for this metric to prevent service interruptions. Any partition without an active leader will be completely inaccessible, and both consumers and producers of that partition will be blocked until a leader becomes available.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| offline_partitions_filter_override     | ""                                       | No       |                                  |
| offline_partitions_alerting_enabled    | True                                     | No       |                                  |
| offline_partitions_require_full_window | True                                     | No       |                                  |
| offline_partitions_priority            | 2                                        | No       | Number from 1 (high) to 5 (low). |


## Produce_purgatory_size

  The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  If request.required.acks=-1, all produce requests will end up in purgatory until the partition leader receives an acknowledgment from all followers.

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_15m):max:kafka.request.producer_request_purgatory.size{tag:xxx} > 200
```

| variable                                   | default                                  | required | description                      |
|--------------------------------------------|------------------------------------------|----------|----------------------------------|
| produce_purgatory_size_enabled             | True                                     | No       |                                  |
| produce_purgatory_size_warning             | 100                                      | No       |                                  |
| produce_purgatory_size_critical            | 200                                      | No       |                                  |
| produce_purgatory_size_evaluation_period   | last_15m                                 | No       |                                  |
| produce_purgatory_size_note                | ""                                       | No       |                                  |
| produce_purgatory_size_docs                | The request purgatory serves as a temporary holding pen for produce and fetch requests waiting to be satisfied.
  If request.required.acks=-1, all produce requests will end up in purgatory until the partition leader receives an acknowledgment from all followers.

  Keeping an eye on the size of purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| produce_purgatory_size_filter_override     | ""                                       | No       |                                  |
| produce_purgatory_size_alerting_enabled    | True                                     | No       |                                  |
| produce_purgatory_size_require_full_window | True                                     | No       |                                  |
| produce_purgatory_size_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unclean_leader_election

  Unclean leader elections occur when there is no qualified partition leader among Kafka brokers. Normally, when a broker that is the leader for a partition goes offline, a new leader is elected from the set of ISRs for the partition. Unclean leader election is disabled by default in Kafka version 0.11 and newer, meaning that a partition is taken offline if it does not have any ISRs to elect as the new leader. If Kafka is configured to allow an unclean leader election, a leader is chosen from the out-of-sync replicas, and any messages that were not synced prior to the loss of the former leader are lost forever. Essentially, unclean leader elections sacrifice consistency for availability. You should alert on this metric, as it signals data loss.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_5m):max:kafka.replication.unclean_leader_elections.rate{tag:xxx} by {aiven-project} > 
```

| variable                                    | default                                  | required | description                      |
|---------------------------------------------|------------------------------------------|----------|----------------------------------|
| unclean_leader_election_enabled             | True                                     | No       |                                  |
| unclean_leader_election_warning             | 100                                      | No       |                                  |
| unclean_leader_election_critical            | 0                                        | No       |                                  |
| unclean_leader_election_evaluation_period   | last_5m                                  | No       |                                  |
| unclean_leader_election_note                | ""                                       | No       |                                  |
| unclean_leader_election_docs                | Unclean leader elections occur when there is no qualified partition leader among Kafka brokers. Normally, when a broker that is the leader for a partition goes offline, a new leader is elected from the set of ISRs for the partition. Unclean leader election is disabled by default in Kafka version 0.11 and newer, meaning that a partition is taken offline if it does not have any ISRs to elect as the new leader. If Kafka is configured to allow an unclean leader election, a leader is chosen from the out-of-sync replicas, and any messages that were not synced prior to the loss of the former leader are lost forever. Essentially, unclean leader elections sacrifice consistency for availability. You should alert on this metric, as it signals data loss.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| unclean_leader_election_filter_override     | ""                                       | No       |                                  |
| unclean_leader_election_alerting_enabled    | True                                     | No       |                                  |
| unclean_leader_election_require_full_window | False                                    | No       |                                  |
| unclean_leader_election_priority            | 2                                        | No       | Number from 1 (high) to 5 (low). |


## Under_replicated_partitions

  If a broker becomes unavailable, the value of UnderReplicatedPartitions will increase sharply. Since Kafka’s high-availability guarantees cannot be met without replication, investigation is certainly warranted should this metric value exceed zero for extended time periods.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/

Query:
```terraform
avg(last_15m):avg:kafka.replication.under_replicated_partitions{tag:xxx} by {aiven-service} > 
```

| variable                                        | default                                  | required | description                      |
|-------------------------------------------------|------------------------------------------|----------|----------------------------------|
| under_replicated_partitions_enabled             | True                                     | No       |                                  |
| under_replicated_partitions_warning             | 100                                      | No       |                                  |
| under_replicated_partitions_critical            | 0                                        | No       |                                  |
| under_replicated_partitions_evaluation_period   | last_15m                                 | No       |                                  |
| under_replicated_partitions_note                | ""                                       | No       |                                  |
| under_replicated_partitions_docs                | If a broker becomes unavailable, the value of UnderReplicatedPartitions will increase sharply. Since Kafka’s high-availability guarantees cannot be met without replication, investigation is certainly warranted should this metric value exceed zero for extended time periods.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/ | No       |                                  |
| under_replicated_partitions_filter_override     | ""                                       | No       |                                  |
| under_replicated_partitions_alerting_enabled    | True                                     | No       |                                  |
| under_replicated_partitions_require_full_window | True                                     | No       |                                  |
| under_replicated_partitions_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unusual_consumer_fetch_time

  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems

Query:
```terraform
avg(last_30m):avg:kafka.request.fetch_consumer.time.avg{tag:xxx} > 1000
```

| variable                                        | default                                  | required | description                      |
|-------------------------------------------------|------------------------------------------|----------|----------------------------------|
| unusual_consumer_fetch_time_enabled             | True                                     | No       |                                  |
| unusual_consumer_fetch_time_warning             | 800                                      | No       |                                  |
| unusual_consumer_fetch_time_critical            | 1000                                     | No       |                                  |
| unusual_consumer_fetch_time_evaluation_period   | last_30m                                 | No       |                                  |
| unusual_consumer_fetch_time_note                | ""                                       | No       |                                  |
| unusual_consumer_fetch_time_docs                | produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems | No       |                                  |
| unusual_consumer_fetch_time_filter_override     | ""                                       | No       |                                  |
| unusual_consumer_fetch_time_alerting_enabled    | True                                     | No       |                                  |
| unusual_consumer_fetch_time_require_full_window | True                                     | No       |                                  |
| unusual_consumer_fetch_time_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unusual_fetch_failures

  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task

Query:
```terraform
avg(last_30m):avg:kafka.request.fetch.failed.rate{tag:xxx} > 50
```

| variable                                   | default                                  | required | description                      |
|--------------------------------------------|------------------------------------------|----------|----------------------------------|
| unusual_fetch_failures_enabled             | True                                     | No       |                                  |
| unusual_fetch_failures_warning             | 40                                       | No       |                                  |
| unusual_fetch_failures_critical            | 50                                       | No       |                                  |
| unusual_fetch_failures_evaluation_period   | last_30m                                 | No       |                                  |
| unusual_fetch_failures_note                | ""                                       | No       |                                  |
| unusual_fetch_failures_docs                | produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task | No       |                                  |
| unusual_fetch_failures_filter_override     | ""                                       | No       |                                  |
| unusual_fetch_failures_alerting_enabled    | True                                     | No       |                                  |
| unusual_fetch_failures_require_full_window | True                                     | No       |                                  |
| unusual_fetch_failures_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unusual_follower_fetch_time

  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data
  
  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems

Query:
```terraform
avg(last_30m):avg:kafka.request.fetch_follower.time.avg{tag:xxx} > 1000
```

| variable                                        | default                                  | required | description                      |
|-------------------------------------------------|------------------------------------------|----------|----------------------------------|
| unusual_follower_fetch_time_enabled             | True                                     | No       |                                  |
| unusual_follower_fetch_time_warning             | 800                                      | No       |                                  |
| unusual_follower_fetch_time_critical            | 1000                                     | No       |                                  |
| unusual_follower_fetch_time_evaluation_period   | last_30m                                 | No       |                                  |
| unusual_follower_fetch_time_note                | ""                                       | No       |                                  |
| unusual_follower_fetch_time_docs                | produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data
  
  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems | No       |                                  |
| unusual_follower_fetch_time_filter_override     | ""                                       | No       |                                  |
| unusual_follower_fetch_time_alerting_enabled    | True                                     | No       |                                  |
| unusual_follower_fetch_time_require_full_window | True                                     | No       |                                  |
| unusual_follower_fetch_time_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unusual_produce_failures

  The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):
  
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task

Query:
```terraform
avg(last_30m):avg:kafka.request.produce.failed.rate{tag:xxx} > 50
```

| variable                                     | default                                  | required | description                      |
|----------------------------------------------|------------------------------------------|----------|----------------------------------|
| unusual_produce_failures_enabled             | True                                     | No       |                                  |
| unusual_produce_failures_warning             | 40                                       | No       |                                  |
| unusual_produce_failures_critical            | 50                                       | No       |                                  |
| unusual_produce_failures_evaluation_period   | last_30m                                 | No       |                                  |
| unusual_produce_failures_note                | ""                                       | No       |                                  |
| unusual_produce_failures_docs                | The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):
  
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task | No       |                                  |
| unusual_produce_failures_filter_override     | ""                                       | No       |                                  |
| unusual_produce_failures_alerting_enabled    | True                                     | No       |                                  |
| unusual_produce_failures_require_full_window | True                                     | No       |                                  |
| unusual_produce_failures_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Unusual_produce_time

  The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):
  
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task

Query:
```terraform
avg(last_30m):avg:kafka.request.produce.time.avg{tag:xxx} > 20
```

| variable                                 | default                                  | required | description                      |
|------------------------------------------|------------------------------------------|----------|----------------------------------|
| unusual_produce_time_enabled             | True                                     | No       |                                  |
| unusual_produce_time_warning             | 10                                       | No       |                                  |
| unusual_produce_time_critical            | 20                                       | No       |                                  |
| unusual_produce_time_evaluation_period   | last_30m                                 | No       |                                  |
| unusual_produce_time_note                | ""                                       | No       |                                  |
| unusual_produce_time_docs                | The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request):
  
  produce: requests from producers to send data
  fetch-consumer: requests from consumers to get new data
  fetch-follower: requests from brokers that are the followers of a partition to get new data

  Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.
  
  https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/#metric-to-watch-totaltimems
  
  This monitor checks if there's an unusual high amount of failures. Which might be indicative of the application not being able to perform its task | No       |                                  |
| unusual_produce_time_filter_override     | ""                                       | No       |                                  |
| unusual_produce_time_alerting_enabled    | True                                     | No       |                                  |
| unusual_produce_time_require_full_window | True                                     | No       |                                  |
| unusual_produce_time_priority            | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Module Variables

| variable                             | default  | required | description                                              |
|--------------------------------------|----------|----------|----------------------------------------------------------|
| env                                  |          | Yes      |                                                          |
| service                              | Kafka    | No       |                                                          |
| notification_channel                 |          | Yes      |                                                          |
| additional_tags                      | []       | No       |                                                          |
| filter_str                           |          | Yes      |                                                          |
| is_hosted_service                    | False    | No       |                                                          |
| locked                               | True     | No       |                                                          |
| system_notification_channel_override | None     | No       |                                                          |
| name_prefix                          | ""       | No       | Can be used to prefix to the Monitor name                |
| name_suffix                          | ""       | No       | Can be used to suffix to the Monitor name                |
| priority_offset                      | 0        | No       | For non production workloads we can +1 on the priorities |


