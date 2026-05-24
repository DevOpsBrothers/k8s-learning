# Kubernetes Learning Notes — Part 1

## Cluster Setup Status

Current cluster:

```bash
kubectl get nodes
```

Output:

```text
NAME                        STATUS   ROLES           AGE    VERSION
k8s-cluster-control-plane   Ready    control-plane   112m   v1.35.0
k8s-cluster-worker          Ready    <none>          112m   v1.35.0
k8s-cluster-worker2         Ready    <none>          112m   v1.35.0
```

Cluster topology:

```text
1 Control Plane
2 Worker Nodes
```

This is enough to practice:

- Pods
- Scheduling
- Labels
- ReplicaSets
- Deployments
- DaemonSets
- Affinity
- Anti-Affinity
- Services
- Rolling Updates
- Self-healing

---

# Vim + Terminal Productivity Notes

## Check Server Uptime

```bash
uptime
```

Pretty format:

```bash
uptime -p
```

Check boot time:

```bash
who -b
```

Check exact uptime start:

```bash
uptime -s
```

---

# Timezone Configuration

EC2 instances usually use UTC.

Set IST:

```bash
sudo timedatectl set-timezone Asia/Kolkata
```

Verify:

```bash
timedatectl
```

Useful note:

Production systems usually remain in UTC.
Reasons:

- consistent logging
- distributed systems
- avoids timezone issues
- easier debugging

---

# Kubernetes Core Mental Model

Kubernetes is:

```text
Desired State Reconciliation Engine
```

You declare:

```text
I WANT THIS
```

Kubernetes continuously tries to make actual state match desired state.

---

# Kubernetes Object Anatomy

Most Kubernetes objects contain:

```yaml
apiVersion:
kind:
metadata:
spec:
```

---

# PODS

## Definition

Pod = smallest deployable unit in Kubernetes.

Kubernetes schedules Pods, not containers.

A Pod may contain:

- one container
- multiple tightly coupled containers

---

# Pod Architecture

```text
Node (VM)
 └── Pod
      └── Container
```

---

# First Pod YAML

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod
  labels:
    app: nginx

spec:
  containers:
    - name: nginx-container
      image: nginx:stable
      ports:
        - containerPort: 80
```

Apply:

```bash
kubectl apply -f pod.yml
```

---

# Important Commands

## Get Pods

```bash
kubectl get pods
```

Alias used:

```bash
k get pods
```

---

## Detailed Pod View

```bash
kubectl get pods -o wide
```

Shows:

- Pod IP
- Node assignment
- Status
- Restart count

Example:

```text
NAME        READY   STATUS    RESTARTS   AGE   IP           NODE
nginx-pod   1/1     Running   0          35s   10.244.2.2   k8s-cluster-worker
```

---

# Scheduler Behavior

Scheduler selected:

```text
k8s-cluster-worker
```

Scheduler decides placement based on:

- available resources
- affinity
- taints/tolerations
- constraints

Current scheduling is simple because no constraints exist yet.

---

# Pod IP Model

Every Pod gets:

- unique IP
- flat network access

Meaning:

```text
Every pod can talk to every other pod.
```

Without traditional NAT complexity.

---

# Pod Lifecycle Observation

Watch pod lifecycle:

```bash
kubectl get pods -w
```

Possible states:

- Pending
- ContainerCreating
- Running
- Terminating
- CrashLoopBackOff

---

# Describe Pod

Most important debugging command:

```bash
kubectl describe pod nginx-pod
```

Shows:

- events
- image pull status
- node placement
- IPs
- volumes
- conditions
- scheduling details

---

# Logs

```bash
kubectl logs nginx-pod
```

For multi-container pods:

```bash
kubectl logs nginx-pod -c container-name
```

---

# Exec Into Container

```bash
kubectl exec -it nginx-pod -- bash
```

If bash unavailable:

```bash
kubectl exec -it nginx-pod -- sh
```

---

# Pods Are Ephemeral

Pods are disposable.

Never depend on:

- pod IP
- local filesystem
- pod permanence

Deleting pod:

```bash
kubectl delete pod nginx-pod
```

Pod disappears permanently.

Cloud-native principle:

```text
Pets ❌
Cattle ✅
```

---

# Multi-Container Pods

Attempted update:

```yaml
- name: log-sidecar
  image: busybox
```

Error:

```text
spec.containers: Forbidden: pod updates may not add or remove containers
```

---

# Important Concept — Pod Immutability

Most core Pod spec fields are immutable.

Kubernetes prefers:

```text
Delete old pod → create new pod
```

Reason:

- predictable scheduling
- stable reconciliation
- avoids runtime chaos

---

# Correct Multi-Container Pod Example

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod
  labels:
    app: nginx

spec:
  containers:
    - name: nginx-container
      image: nginx:stable

    - name: log-sidecar
      image: busybox
      command: ["sh", "-c", "while true; do echo hello; sleep 5; done"]
```

Recreate pod:

```bash
kubectl delete pod nginx-pod
kubectl apply -f pod.yml
```

---

# Multi-Container Pod Concepts

Containers inside same pod share:

| Resource          | Shared? |
| ----------------- | ------- |
| Network namespace | Yes     |
| Pod IP            | Yes     |
| localhost access  | Yes     |
| Volumes           | Yes     |
| Lifecycle         | Yes     |

Visualization:

```text
Pod IP: 10.244.2.2

 ├── nginx-container
 │     localhost:80
 │
 └── log-sidecar
       can access localhost:80
```

---

# Sidecar Pattern

Common production sidecars:

| Sidecar          | Purpose          |
| ---------------- | ---------------- |
| Fluentbit        | log shipping     |
| Envoy            | service mesh     |
| Vault agent      | secrets          |
| Monitoring agent | metrics          |
| Security scanner | runtime scanning |

---

# LABELS & SELECTORS

## Definition

Labels are:

```text
key=value metadata
```

Example:

```yaml
labels:
  app: nginx
  env: dev
  team: sre
  tier: frontend
```

Labels power:

- Services
- ReplicaSets
- Deployments
- Affinity
- Monitoring
- Traffic routing
- Filtering

---

# Important Mental Model

Kubernetes controllers do NOT track pod names.

They query:

```text
Which pods match my selector?
```

---

# View Labels

```bash
kubectl get pods --show-labels
```

---

# Label Selectors

## Single Label

```bash
kubectl get pods -l app=nginx
```

---

## Multiple Labels

```bash
kubectl get pods -l app=nginx,env=dev
```

---

## Wrong Selector Example

```bash
kubectl get pods -l env=prod
```

Result:

```text
No resources found
```

Selectors require exact matches.

---

# Dynamic Labels

Add label:

```bash
kubectl label pod nginx-pod owner=pritam
```

Remove label:

```bash
kubectl label pod nginx-pod owner-
```

---

# Important Architecture Concept

ReplicaSet works like:

```text
Maintain N pods matching selector X
```

Not:

```text
Maintain specific pod names
```

Selectors are everything.

---

# matchLabels Example

```yaml
selector:
  matchLabels:
    app: nginx
```

Meaning:

```text
Manage all pods matching app=nginx
```

---

# Production Risk Example

If Deployment selector:

```yaml
app=nginx
```

And another pod accidentally gets:

```yaml
app=nginx
```

Deployment may adopt it.

Label strategy matters heavily in enterprises.

---

# Recommended Label Strategy

```yaml
labels:
  app: payment-api
  env: prod
  version: v1
  team: sre
  tier: backend
```

Useful for:

- observability
- routing
- canary deployments
- monitoring
- ownership
- debugging

---

# Kubernetes Core Architecture

Kubernetes fundamentally works as:

```text
Controllers + Selectors + Reconciliation
```

---

# Useful Commands Learned

## Nodes

```bash
kubectl get nodes
```

Alias:

```bash
knode
```

---

## Pods

```bash
kubectl get pods
```

---

## Wide Output

```bash
kubectl get pods -o wide
```

---

## YAML Runtime View

```bash
kubectl get pod nginx-pod -o yaml
```

Very important.
Shows:

- actual runtime state
- status
- pod IP
- node assignment
- generated fields

---

# Important Learning Summary

## Pods

- smallest deployable unit
- ephemeral
- share networking internally
- not usually managed directly in production

---

## Labels

- metadata-driven orchestration
- selectors are Kubernetes query engine
- controllers rely heavily on labels

---

## Multi-Container Pods

- tightly coupled workloads
- sidecar architecture
- shared localhost + network namespace

---

## Pod Immutability

- core pod structure cannot be changed after creation
- recreate instead of mutating deeply

---

# NEXT TOPICS

Upcoming learning path:

1. ReplicaSet
2. Deployment
3. Rolling Updates
4. Self-healing
5. DaemonSet
6. Affinity
7. Anti-Affinity
8. StatefulSet
9. Services
10. Ingress

---

# Future Learning Goal

Target mindset:

```text
Stop managing containers.
Start managing desired state.
```

That is Kubernetes engineering.
