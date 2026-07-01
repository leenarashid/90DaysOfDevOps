
# Day 73 -- Introduction to Observability and Prometheus

## Challenge Tasks

### Task 1: Understand Observability
Research and write short notes on:

1. What is observability? How is it different from traditional monitoring?
   - **Monitoring** tells you _when_ something is wrong (alerts, thresholds)
   - **Observability** tells you _why_ something is wrong (explore, query, correlate)
**Answer:**

>**Monitoring**	              

- Detects problems	       
- Uses predefined metrics    
- Works for known failures	
	                   	

>** Observability**
- Explains problems
- Uses metrics, logs, traces
- Helps discover unknown failures







1. The three pillars of observability:
   - **Metrics** -- numerical measurements over time (CPU usage, request count, error rate). Tools: Prometheus, Datadog, CloudWatch
   - **Logs** -- timestamped text records of events (application output, error messages). Tools: Loki, ELK Stack, Fluentd
   - **Traces** -- the journey of a single request across multiple services. Tools: OpenTelemetry, Jaeger, Zipkin



2. Why do DevOps engineers need all three?
   - Metrics tell you _what_ is broken (high error rate on `/api/users`)
   - Logs tell you _why_ it broke (stack trace showing a database timeout)
   - Traces tell you _where_ it broke (the payment service call took 12 seconds)

3. Draw or describe this architecture -- this is what you will build over the next 5 days:
   ```
   [Your App] --> metrics --> [Prometheus] --> [Grafana Dashboards]
   [Your App] --> logs    --> [Promtail]   --> [Loki] --> [Grafana]
   [Your App] --> traces  --> [OTEL Collector] --> [Grafana/Debug]
   [Host]     --> metrics --> [Node Exporter] --> [Prometheus]
   [Docker]   --> metrics --> [cAdvisor] --> [Prometheus]
   ```

<img src="images/Architecture Diagram.png" width="700">



 Component                   | Purpose                                       | Data Type             |
| --------------------------- | --------------------------------------------- | --------------------- |
| **Your App**                | Generates metrics, logs, and traces           | Metrics, Logs, Traces |
| **Prometheus**              | Scrapes and stores metrics                    | Metrics               |
| **Promtail**                | Reads application log files and forwards them | Logs                  |
| **Loki**                    | Stores and indexes logs                       | Logs                  |
| **OpenTelemetry Collector** | Receives, processes, and exports traces       | Traces                |
| **Node Exporter**           | Exposes host/server metrics                   | Metrics               |
| **cAdvisor**                | Exposes Docker container metrics              | Metrics               |
| **Grafana**                 | Visualizes metrics, logs, and traces          | Visualization         |



---

### Task 2: Set Up Prometheus with Docker
Create a project directory for this entire observability block -- you will keep adding to it over the next 5 days.

```bash
mkdir observability-stack && cd observability-stack
```

Create a `prometheus.yml` configuration file:
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
```

This tells Prometheus to scrape its own metrics every 15 seconds.

Create a `docker-compose.yml` to run Prometheus:
```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    restart: unless-stopped

volumes:
  prometheus_data:
```

Start Prometheus:
```bash
docker compose up -d
```

Open `http://localhost:9090` in your browser. You should see the Prometheus web UI.


<img src="images/2.0.png" width="700">

<img src="images/2.1.png" width="700">


**Verify:** Go to Status > Targets. You should see one target (`prometheus`) with state `UP`.

**Answer:**



<img src="images/2.2.png" width="700">

---

### Task 3: Understand Prometheus Concepts
Explore the Prometheus UI and understand these concepts:

1. **Scrape targets** -- endpoints that Prometheus pulls metrics from at regular intervals (pull-based model)
2. **Metrics types:**
   - `Counter` -- only goes up (total requests served, total errors)
   - `Gauge` -- goes up and down (current CPU usage, memory in use, active connections)
   - `Histogram` -- distribution of values in buckets (request duration: how many took <100ms, <500ms, <1s)
   - `Summary` -- similar to histogram but calculates percentiles on the client side
3. **Labels** -- key-value pairs that add dimensions to metrics (e.g., `http_requests_total{method="GET", status="200"}`)
4. **Time series** -- a unique combination of metric name + labels

Go to the Prometheus UI graph page (`http://localhost:9090/graph`) and run these queries:


> How many metrics is Prometheus collecting about itself?
>count({__name__=~".+"})

  <img src="images/3.1.png" width="700">


> How much memory is Prometheus using?
>process_resident_memory_bytes



<img src="images/3.2.png" width="700">




> Total HTTP requests to the Prometheus server
>prometheus_http_requests_total





<img src="images/3.3.png" width="700">


> Break it down by handler
>prometheus_http_requests_total{handler="/api/v1/query"}



 <img src="images/3.4.png" width="700">


**Document:** What is the difference between a counter and a gauge? Give one real-world example of each.

**Answer:**
| Feature              | Counter                                                                         | Gauge                                                                         |
| -------------------- | ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **Definition**       | A metric that only increases over time (except when it resets after a restart). | A metric that can increase or decrease at any time.                           |
| **Value Direction**  | Only goes up.                                                                   | Goes up and down.                                                             |
| **Reset Behavior**   | Resets to 0 when the application restarts.                                      | Does not have a special reset behavior; it simply reflects the current value. |
| **Purpose**          | Counts the total number of events that have occurred.                           | Measures the current state or value of something.                             |
| **PromQL Functions** | Commonly used with `rate()`, `increase()`, and `irate()`.                       | Typically queried directly without `rate()`.                                  |


---

### Task 4: Learn PromQL Basics
PromQL (Prometheus Query Language) is how you ask questions about your metrics. Run these queries in the Prometheus UI:

1. **Instant vector** -- current value of a metric:
```promql
up
```


 



This returns 1 (up) or 0 (down) for each scrape target.

 <img src="images/4.1.png" width="700">


2. **Range vector** -- values over a time window:
```promql
prometheus_http_requests_total[5m]
```



Returns all values from the last 5 minutes.

 <img src="images/4.2.png" width="700">


3. **Rate** -- per-second rate of a counter over a time window:
```promql
rate(prometheus_http_requests_total[5m])
```
This is the most common function you will use. Counters always go up -- `rate()` converts them to a useful per-second speed.



 <img src="images/4.3.png" width="700">

4. **Aggregation** -- sum across all label combinations:
```promql
sum(rate(prometheus_http_requests_total[5m]))
```

 <img src="images/4.4.png" width="700">


5. **Filter by label:**
```promql
prometheus_http_requests_total{code="200"}
prometheus_http_requests_total{code!="200"}
```
 <img src="images/4.5(new).png" width="700">

 <img src="images/4.6(new).png" width="700">


6. **Arithmetic:**
```promql
process_resident_memory_bytes / 1024 / 1024
```
This converts bytes to megabytes.


 <img src="images/4.7.png" width="700">


7. **Top-K:**
```promql
topk(5, prometheus_http_requests_total)
```
 <img src="images/4.8(1).png" width="700">

  <img src="images/4.8(2).png" width="700">



**Try this exercise:** Write a PromQL query that shows the per-second rate of non-200 HTTP requests to Prometheus over the last 5 minutes. (Hint: use `rate()` with a label filter on `code!="200"`)

**TO DO!!**

---

### Task 5: Add a Sample Application as a Scrape Target
Prometheus needs something to monitor. Add a simple metrics-generating service.

Update your `docker-compose.yml` to include a sample app that exposes Prometheus metrics:
```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    restart: unless-stopped

  notes-app:
    image: trainwithshubham/notes-app:latest
    container_name: notes-app
    ports:
      - "8000:8000"
    restart: unless-stopped

volumes:
  prometheus_data:
```

Update `prometheus.yml` to scrape the app:
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "notes-app"
    static_configs:
      - targets: ["notes-app:8000"]
```

Restart the stack:
```bash
docker compose up -d
```

Go back to Status > Targets. You should now see two targets. Generate some traffic to the app:
```bash
curl http://localhost:8000
curl http://localhost:8000
curl http://localhost:8000
```
 <img src="images/5.1.png" width="700">

  <img src="images/5.2.png" width="700">

---

### Task 6: Explore Data Retention and Storage
Understand how Prometheus stores data:

1. Check how much disk space Prometheus is using:
```bash
docker exec prometheus du -sh /prometheus
```

 <img src="images/6.0.png" width="700">


2. Prometheus stores data in a local time-series database (TSDB). Default retention is **15 days**. You can change it:
```yaml
command:
  - '--config.file=/etc/prometheus/prometheus.yml'
  - '--storage.tsdb.retention.time=30d'
  - '--storage.tsdb.retention.size=1GB'
```

3. Check the TSDB status in the UI: Status > TSDB Status

 <img src="images/6.png" width="700">



**Document:** What happens when retention is exceeded? Why is a volume mount important for Prometheus data?

**Answer**

>Prometheus Retention

- When Prometheus retention is exceeded, older time-series data is automatically deleted through compaction and garbage collection to free disk space. Only the most recent data within the configured retention window is kept.

>Volume Mount In Prometheus:

- A volume mount is critical because Prometheus stores its entire time-series database locally on disk. Without a persistent volume, all metrics data is lost whenever the container restarts or is redeployed. In production, volume mounts ensure data durability, enable historical analysis, and make the observability stack reliable across restarts and upgrades.

---

## Hints
- Prometheus uses a **pull model** -- it scrapes targets at regular intervals, unlike push-based systems
- The `up` metric is automatically created for every scrape target -- 1 means healthy, 0 means the target is unreachable
- `rate()` only works on counters, not gauges -- applying rate to a gauge gives meaningless results
- Always use `rate()` before `sum()` when aggregating counters: `sum(rate(...))` not `rate(sum(...))`
- If a target shows as DOWN in Status > Targets, check: is the container running? Is the port correct? Are they on the same Docker network?
- `prometheus.yml` changes require a restart or a POST to `/-/reload` (if `--web.enable-lifecycle` flag is set)
- Reference repo for the full stack: https://github.com/LondheShubham153/observability-for-devops




