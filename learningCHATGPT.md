Beautiful.
Now you’re entering the part where Kubernetes actually starts making architectural sense instead of looking like YAML tax.

Your cluster is healthy:

```text id="v3rcsx"
1 control-plane
2 workers
```

That’s enough to properly learn:

* scheduling
* replicas
* affinity
* daemonsets
* rolling updates
* failure simulation

Exactly the right playground.

---

# Kubernetes Learning Path (Practical Order)

We’ll go in this order because each concept builds on the previous one:

1. Pods
2. Labels & Selectors
3. ReplicaSet
4. Deployment
5. DaemonSet
6. Affinity / Anti-Affinity
7. StatefulSet later
8. Services + Ingress later

Today → Pods.

---

# 1. PODS — The Atomic Unit of Kubernetes

A Pod is:

> the smallest deployable unit in Kubernetes.

Not a container.

Kubernetes schedules **Pods**, not containers.

A Pod can contain:

* one container (common)
* multiple tightly coupled containers (sidecar pattern)

---

# Think Like This

```text id="1w5iv0"
Node (VM)
 └── Pod
      └── Container
```

---

# Your First Pod

Create file:

```bash id="d8ccod"
vim nginx-pod.yaml
```

YAML:

```yaml id="0byx4v"
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod
  labels:
    app: nginx

spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
```

Apply:

```bash id="pjrd51"
kubectl apply -f nginx-pod.yaml
```

---

# Check Pod

```bash id="gqu2rv"
kubectl get pods
```

Detailed:

```bash id="4bngk4"
kubectl get pods -o wide
```

You’ll see:

* pod IP
* node placement
* status
* restart count

Example:

```text id="z6g4zi"
NAME        READY   STATUS    NODE
nginx-pod   1/1     Running   k8s-cluster-worker
```

---

# Describe Pod

MOST IMPORTANT DEBUG COMMAND.

```bash id="wvl8ho"
kubectl describe pod nginx-pod
```

This gives:

* node placement
* image pull
* events
* mounts
* IP
* scheduling info

Production engineers live inside this command.

---

# Logs

```bash id="e6v23x"
kubectl logs nginx-pod
```

---

# Enter Container

```bash id="j5m1xj"
kubectl exec -it nginx-pod -- bash
```

If bash missing:

```bash id="zq7khz"
kubectl exec -it nginx-pod -- sh
```

---

# Delete Pod

```bash id="ozw9ef"
kubectl delete pod nginx-pod
```

---

# CRITICAL POD CONCEPTS

---

# Pods are EPHEMERAL

This is foundational.

If pod dies:

* IP changes
* recreated elsewhere
* storage lost unless persistent

Never depend on:

* pod IP
* local pod filesystem

This is where many beginners get wrecked.

---

# Scheduler

When you create a pod:

```text id="j9m2gt"
kubectl apply
    ↓
API Server
    ↓
Scheduler chooses node
    ↓
Kubelet runs container
```

---

# Observe Scheduling

Run:

```bash id="s0cx79"
kubectl get pods -o wide
```

Notice:

* which worker got pod
* scheduler decisions

Delete pod and recreate:
sometimes node changes.

---

# Multi-Container Pod (Sidecar Pattern)

Example:

```yaml id="2qszvk"
spec:
  containers:
  - name: app
    image: nginx

  - name: log-sidecar
    image: busybox
```

Containers share:

* network
* localhost
* storage volumes

Used heavily in:

* logging
* monitoring
* service mesh

---

# IMPORTANT LABS

Do these NOW.

---

# LAB 1 — Run BusyBox

```bash id="ah7xww"
kubectl run busybox --image=busybox -- sleep 3600
```

Check:

```bash id="5mngh4"
kubectl get pods
```

Exec into it:

```bash id="2xj4na"
kubectl exec -it busybox -- sh
```

---

# LAB 2 — Check Pod IP

```bash id="w7v5jl"
kubectl get pods -o wide
```

Notice:

* pod has private IP
* node assignment

---

# LAB 3 — Delete Pod

```bash id="r6vjlwm"
kubectl delete pod busybox
```

Pod gone permanently.

This teaches:

> Pods are cattle, not pets.

Very important cloud-native mindset.

---

# LAB 4 — Watch Pod Lifecycle

Open another terminal:

```bash id="17k5y1"
kubectl get pods -w
```

Then create/delete pods.

Watch:

* Pending
* ContainerCreating
* Running
* Terminating

This teaches real lifecycle.

---

# Production Reality

In real companies:

* nobody manually manages pods
* Deployments manage pods
* ReplicaSets maintain count
* DaemonSets run infra agents

Pods are building blocks.

---

# NEXT TOPIC (After You Practice)

We should do:

# Labels & Selectors

Because:

* ReplicaSet depends on it
* Deployment depends on it
* Services depend on it
* Affinity depends on it

Labels are basically:

> Kubernetes metadata-driven orchestration engine.

Without understanding labels, Kubernetes feels random.

---

# Your Homework

Run ALL these:

```bash id="jcbnpt"
kubectl get nodes
kubectl get pods
kubectl get pods -o wide
kubectl describe pod nginx-pod
kubectl logs nginx-pod
kubectl exec -it nginx-pod -- bash
```

Then:

* create
* inspect
* delete
* recreate

Until it feels natural.

That repetition matters more than reading theory PDFs nobody remembers after lunch.
