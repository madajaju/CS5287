# Primer on Docker Swarm

Docker Swarm is Docker’s built-in orchestration engine. It enables you to create and manage a cluster of Docker Engines as a single, virtual Docker Engine.

---

## Key Concepts

- **Swarm**  
  A group of one or more Docker hosts (nodes) acting as a single, virtual Docker Engine.

- **Node**  
  A Docker Engine participating in a Swarm, either as a **manager** (schedules tasks, maintains state) or a **worker** (runs containers).

- **Service**  
  Declarative definition of a containerized task. Defines the image, command, number of replicas, networks, configs, and secrets.

- **Task**  
  A single container instance running as part of a service.

- **Stack**  
  A collection of services defined in a `docker-compose.yml` file, deployed together with `docker stack deploy`.

- **Overlay Network**  
  Virtual network spanning multiple hosts, enabling containers on different nodes to communicate seamlessly.

- **Configs & Secrets**  
  Swarm-native mechanisms for managing non-sensitive (configs) and sensitive (secrets) data.

---

## Getting Started

### Initialize a Swarm

```shell script
# On the first manager node
docker swarm init --advertise-addr <MANAGER-IP>
```


### Join Additional Nodes

```shell script
# On each worker node, using the token from swarm init
docker swarm join --token <WORKER_TOKEN> <MANAGER-IP>:2377
```


### Verify Nodes

```shell script
docker node ls
```


---

## Deploying Services

### Create a Service

```shell script
docker service create \
  --name web \
  --replicas 3 \
  --publish published=80,target=80 \
  nginx:latest
```


### Update a Service (Rolling Update)

```shell script
docker service update \
  --image nginx:1.21 \
  --update-parallelism 1 \
  --update-delay 10s \
  web
```


### Inspect & Scale

```shell script
docker service ps web
docker service scale web=5
```


---

## Stacks and Compose

### Define `docker-compose.yml`

```yaml
version: "3.8"
services:
  app:
    image: myapp:latest
    deploy:
      replicas: 4
      update_config:
        parallelism: 1
        delay: 5s
    ports:
      - "8080:8080"
    networks:
      - app-net
networks:
  app-net:
    driver: overlay
```


### Deploy Stack

```shell script
docker stack deploy --compose-file docker-compose.yml mystack
```


### Manage Stack

```shell script
docker stack ls
docker stack services mystack
docker stack ps mystack
docker stack rm mystack
```


---

## Networking

- **Overlay** (default for Swarm)
```shell script
docker network create -d overlay app-net
```


- **Attach** services to networks via Compose `networks:` or `--network` flag.

- **Ingress**  
  Default load-balancing mesh for published ports.

---

## Configs & Secrets

### Create a Secret

```shell script
echo "db_password" | docker secret create db_password -
```


### Reference in Compose

```yaml
services:
  db:
    image: postgres:15
    secrets:
      - db_password
secrets:
  db_password:
    external: true
```


### Use Config

```shell script
echo "server: production" | docker config create app_config -
```


---

## High Availability & Fault Tolerance

- **Managers**: run Raft consensus; require odd number (3, 5) for quorum.
- **Workers**: run tasks.
- **Rescheduling**: failed tasks automatically rescheduled on healthy nodes.
- **State Store**: replicated among managers.

---

## Best Practices

- Run at least 3 manager nodes for resilience.
- Label nodes (`docker node update --label-add role=db node1`) and use placement constraints.
- Use health checks in Compose to enable smart rescheduling.
- Limit service update parallelism and delay to prevent downtime.
- Rotate secrets via versioned secret updates and service updates.

---

# Summary

Docker Swarm provides a simple, integrated orchestration layer for Docker containers. With built-in clustering, declarative services, overlay networking, and secrets management, Swarm is ideal for small to medium deployments or teams seeking Docker-native orchestration.