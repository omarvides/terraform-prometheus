# t2.micro", "us-east-1", "prometheus-server"

For drone.io prometheus jobs

```
- job_name: 'drone'
    scheme: https
    bearer_token: SUPERTOKENHERE
    static_configs:
    - targets: ['your.build-server.com']
```