### Day 56 – Kubernetes StatefulSets
----
## Challenge Tasks

### Task 1: Understand the Problem
1. Create a Deployment with 3 replicas using nginx
2. Check the pod names — they are random (`app-xyz-abc`)
3. Delete a pod and notice the replacement gets a different random name

This is fine for web servers but not for databases where you need stable identity.

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random | Stable, ordered (`app-0`, `app-1`) |
| Startup order | All at once | Ordered: pod-0, then pod-1, then pod-2 |
| Storage | Shared PVC | Each pod gets its own PVC |
| Network identity | No stable hostname | Stable DNS per pod |

Delete the Deployment before moving on.


![image](images/task1.png)


**Verify:** Why would random pod names be a problem for a database cluster?

**Answer**
Random pod names are a problem for a database cluster because database systems require stable identity and consistent network endpoints for each node.

In Kubernetes Deployments, pods are created with dynamic, random names, and these names change whenever a pod is recreated. This makes it difficult for database nodes to reliably identify and communicate with each other.

---

### Task 2: Create a Headless Service
1. Write a Service manifest with `clusterIP: None` — this is a Headless Service
2. Set the selector to match the labels you will use on your StatefulSet pods
3. Apply it and confirm CLUSTER-IP shows `None`

A Headless Service creates individual DNS entries for each pod instead of load-balancing to one IP. StatefulSets require this.

![image](images/task2.png)


**Verify:** What does the CLUSTER-IP column show?

**Answer**

The CLUSTER-IP is the internal virtual IP address assigned to a Kubernetes Service. It enables communication between different components (mainly pods) within the cluster.
- It is automatically assigned by Kubernetes when a - Service is created.
- Used for internal communication only (not accessible from outside the cluster).
- Provides a stable endpoint, even if the underlying pods change.
- Helps in load balancing traffic across multiple pods.
- Managed by Kubernetes networking (via kube-proxy or similar mechanisms).
---

### Task 3: Create a StatefulSet
1. Write a StatefulSet manifest with `serviceName` pointing to your Headless Service
2. Set replicas to 3, use the nginx image
3. Add a `volumeClaimTemplates` section requesting 100Mi of ReadWriteOnce storage
4. Apply and watch: `kubectl get pods -l <your-label> -w`

Observe ordered creation — `web-0` first, then `web-1` after `web-0` is Ready, then `web-2`.

Check the PVCs: `kubectl get pvc` — you should see `web-data-web-0`, `web-data-web-1`, `web-data-web-2` (names follow the pattern `<template-name>-<pod-name>`).

![image](images/task3.png.png)


**Verify:** What are the exact pod names and PVC names?

**Answer**
- `Pod-names` web-0, web-1, web-2
- `PVC name` www-web-0, www-web-1,www-web-2

---

### Task 4: Stable Network Identity
Each StatefulSet pod gets a DNS name: `<pod-name>.<service-name>.<namespace>.svc.cluster.local`

1. Run a temporary busybox pod and use `nslookup` to resolve `web-0.<your-headless-service>.default.svc.cluster.local`
2. Do the same for `web-1` and `web-2`
3. Confirm the IPs match `kubectl get pods -o wide`

![image](images/task4.png)
**Verify:** Does the nslookup IP match the pod IP?

**Answer**
Yes, exactly the same.

---

### Task 5: Stable Storage — Data Survives Pod Deletion
1. Write unique data to each pod: `kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"`
2. Delete `web-0`: `kubectl delete pod web-0`
3. Wait for it to come back, then check the data — it should still be "Data from web-0"

The new pod reconnected to the same PVC.


![image](assets/task5.png)

**Verify:** Is the data identical after pod recreation?
**Answer**
Yes the data was preserved at the same place, even after the deletion.
---

### Task 6: Ordered Scaling
1. Scale up to 5: `kubectl scale statefulset web --replicas=5` — pods create in order (web-3, then web-4)
2. Scale down to 3 — pods terminate in reverse order (web-4, then web-3)
3. Check `kubectl get pvc` — all five PVCs still exist. Kubernetes keeps them on scale-down so data is preserved if you scale back up.



![image](images/task6.png)

**Verify:** After scaling down, how many PVCs exist?
**Answer**
In stateful sets, the PVCs are still there even after scaling down.

---

### Task 7: Clean Up
1. Delete the StatefulSet and the Headless Service
2. Check `kubectl get pvc` — PVCs are still there (safety feature)
3. Delete PVCs manually

![image](images/task7.png)

**Verify:** Were PVCs auto-deleted with the StatefulSet?
**Answer**
First I had to delete statefulsets then PVCs , PVCs were still there even after the deletion of stateful sets.


---








