# Kubernetes Scaling

Video: https://youtu.be/p3f11A3C5BI

Kubernetes provides multiple mechanisms to scale workloads and cluster capacity, ensuring applications handle variable load while optimizing resource usage.

---

## Pod Autoscaling

### Horizontal Pod Autoscaler (HPA)

- **What it does**  
  Adjusts the number of Pod replicas in a Deployment/ReplicaSet/StatefulSet based on observed metrics.

- **Supported metrics**
    - **CPU utilization** (built-in)
    - **Memory utilization** (v1.16+)
    - **Custom metrics** (via Metrics API: request rate, queue length)
    - **External metrics** (cloud provider metrics)

**Example**

```yaml
apiVersion: autoscaling/v2
  kind: HorizontalPodAutoscaler
  metadata:
    name: frontend-hpa
  spec:
    scaleTargetRef:
      apiVersion: apps/v1
      kind: Deployment
      name: frontend
    minReplicas: 2
    maxReplicas: 10
    metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 60
```


### Vertical Pod Autoscaler (VPA)

- **What it does**  
  Recommends or automatically adjusts CPU/memory requests and limits for Pods.

- **Modes**
    - **Off (recommendation only)**
    - **Auto**: evicts and recreates Pods with updated resources
    - **Initial**: sets resources only on first creation

- **Use cases**
    - Stateful workloads
    - Reducing overprovisioning

---

## Cluster Autoscaling

### Cluster Autoscaler (CA)

- **What it does**  
  Adjusts the number of nodes in a cluster based on pending Pods or underutilized nodes.

- **Behavior**
    - **Scale up**: when Pods cannot be scheduled due to lack of resources
    - **Scale down**: when nodes are underutilized for a period (no system pods or local data)

- **Integration**
    - Cloud provider–specific implementations (AWS ASG, GKE, AKS VMSS)
    - Custom autoscaler for on-premises clusters

---

## Manual & Scheduled Scaling

- **kubectl scale**  
  Manual adjustment:
```shell script
kubectl scale deployment backend --replicas=5
```


- **CronJob-based scaling**  
  Use a Kubernetes CronJob or external orchestration (e.g., Terraform, Argo CD) to scale at scheduled times:
```yaml
apiVersion: batch/v1beta1
  kind: CronJob
  spec:
    schedule: "0 8 * * *"
    jobTemplate:
      spec:
        template:
          spec:
            containers:
            - name: scaler
              image: bitnami/kubectl
              command:
              - kubectl
              - scale
              - deployment/frontend
              - --replicas=10
            restartPolicy: Never
```


---

## Best Practices

1. **Set sensible min/max replicas**  
   Prevent runaway scaling or insufficient capacity.

2. **Use multiple metrics**  
   Combine CPU, memory, and custom application metrics for robust decisions.

3. **Avoid rapid fluctuations**  
   Configure stabilization windows and thresholds to prevent oscillation.

4. **Consider startup time**  
   Adjust HPA settings to allow Pods time to initialize.

5. **Use PodDisruptionBudget (PDB)**  
   Ensure availability during downsizing or rolling updates.

6. **Monitor scale events**  
   Track scaling actions and metrics in Prometheus/Grafana.

---

## Summary

Kubernetes supports automatic scaling at both Pod and cluster levels. By combining HPA, VPA, and Cluster Autoscaler—alongside manual and scheduled controls—you can build responsive, cost-efficient clusters that adapt to workload demands.
