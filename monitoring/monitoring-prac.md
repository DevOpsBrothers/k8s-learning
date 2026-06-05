
��� Caveman lite mode ON.

---

## Project Outline: Prometheus + Grafana on Kind

I'll give you the mental map. You build it.

---

## The Architecture You're Building

Think about the data flow first:

1. **Prometheus** scrapes metrics from your cluster's components
2. **Grafana** queries Prometheus and visualizes the data
3. Both need to live in your Kind cluster as pods
4. Both need to be discoverable and configured

Before you write any YAML, answer these questions for yourself:

- Should Prometheus and Grafana live in the default namespace or a dedicated one?
- How will Prometheus know *where* to scrape metrics from? (hint: what's the Kubernetes service discovery mechanism?)
- What configuration does Prometheus need to know about scrape targets?
- How will Grafana connect to Prometheus? (hint: Service DNS names)
- What port does each service need to expose, and to whom?

---

## Step-by-Step Hints (Don't Read Ahead — Try First)

**Phase 1: Setup**
- Create a namespace for monitoring tools
- What resources will you need for each application? (Deployment, Service, ConfigMap?)

**Phase 2: Prometheus**
- Prometheus needs a configuration file that tells it *what* to scrape and *how often*
- Where will you store that config file? (hint: ConfigMap, remember?)
- Your `prometheus.yml` config needs at least one scrape job — what's a good first target to monitor? (hint: the Kubernetes API server itself exports metrics)
- Create a Deployment for Prometheus that mounts this config
- Create a Service so Grafana can talk to Prometheus later

**Phase 3: Grafana**
- Grafana is mostly stateless, so a simple Deployment works
- It needs a Service so you can access the web UI from your local machine
- What Service type makes sense here? (hint: you're accessing from outside the cluster)
- Grafana can use environment variables or a config file — which is easier for beginners?

**Phase 4: Connect Them**
- Once both are running, add Prometheus as a datasource in Grafana
- Test by querying a simple metric like `up` (which tells you if scrape targets are responding)

---

## Key Concepts to Use (You Already Know These)

- **Namespace** — organize your monitoring stack separately
- **ConfigMap** — store Prometheus's scrape configuration
- **Deployment** — run Prometheus and Grafana pods
- **Service (ClusterIP)** — let Prometheus and Grafana talk internally
- **Service (NodePort)** — let your localhost access Grafana's web UI
- **Labels and Selectors** — make sure Services find the right pods

---

## Resources You'll Need

- Kind cluster running (you have this)
- Basic `kubectl` commands (apply, get pods, port-forward, logs)
- Text editor for YAML
- One question per step → I'll help you unstick without giving away the answer

Start with Phase 1. Tell me when you've created the namespace and you're ready for Phase 2.
