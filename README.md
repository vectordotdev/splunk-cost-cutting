# Splunk Cost Cutting

This repo houses example code for [Splunk] cost cutting scenarios.

## Running the demo

```bash
docker-compose up
```

## Dashboard

[Grafana]

## Metrics

* [Bytes processed per minute](http://localhost:9090/graph?g0.range_input=1h&g0.expr=rate(bytes_processed%7Bjob%3D%22vector%22%7D%5B1m%5D)&g0.tab=1&g1.range_input=1h&g1.expr=&g1.tab=1)

[grafana]: http://localhost:3000/d/5AEnJvpGz/vector-splunk-copy?orgId=1
[splunk]: https://splunk.com