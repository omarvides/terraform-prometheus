# Prometheus Server

This module can create prometheus servers on AWS

## Required variables are


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami |  | string | `ami-c0f0c0bf` | no |
| instance_type |  | string | `t2.micro` | no |
| name |  | string | `prometheus-server` | no |
| public_key |  | string | - | yes |
| region |  | string | `us-east-1` | no |

## Outputs

| Name | Description |
|------|-------------|
| ami_id |  |
| instance_id |  |
| instance_type |  |
| public_ip |  |
| vpc_security_group_ids |  |


## Configure to scrap metrics from a drone server

For drone.io prometheus jobs

```
- job_name: 'drone'
    scheme: https
    bearer_token: SUPERTOKENHERE
    static_configs:
    - targets: ['your.build-server.com']
```