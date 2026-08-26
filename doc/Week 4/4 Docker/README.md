# Docker Primer

Docker is a platform for building, shipping, and running containerized applications. Containers package code and dependencies together, ensuring consistency across environments.

---

## Core Concepts

- **Image**  
  Read-only template built from a `Dockerfile`. Layers represent filesystem changes.

- **Container**  
  Runtime instance of an image with its own filesystem, processes, network interface, and environment.

- **Dockerfile**  
  Script of instructions (e.g., `FROM`, `RUN`, `COPY`, `ENTRYPOINT`) to assemble an image.

- **Registry**  
  Central repository for images.
    - Public: Docker Hub
    - Private: self-hosted (Harbor, Nexus) or cloud (ECR, GCR, ACR)

---

## Installation

### macOS (Homebrew)

```shell script
brew update
brew install --cask docker
```


### Windows

- Install Docker Desktop for Windows from docker.com
- Enable WSL2 integration if on Windows 10/11

---

## Basic Workflow

1. **Write Dockerfile**
```dockerfile
FROM node:18-alpine
   WORKDIR /app
   COPY package.json yarn.lock ./
   RUN yarn install --frozen-lockfile
   COPY . .
   CMD ["node", "server.js"]
```


2. **Build Image**
```shell script
docker build -t myapp:latest .
```


3. **Run Container**
```shell script
docker run -d \
     --name myapp \
     -p 8080:8080 \
     myapp:latest
```


4. **List Images & Containers**
```shell script
docker images
   docker ps -a
```


5. **Stop & Remove**
```shell script
docker stop myapp
   docker rm myapp
   docker rmi myapp:latest
```


---

## Volumes & Data Persistence

- **Named Volume**
```shell script
docker volume create mydata
  docker run -d -v mydata:/data mydb:latest
```


- **Bind Mount**
```shell script
docker run -d -v "$(pwd)/logs":/app/logs myapp
```


---

## Networking

- **Bridge Network (default)**  
  Containers communicate via `docker0`; port mapping exposes services.

- **User-Defined Bridge**
```shell script
docker network create app-net
  docker run -d --network app-net --name db mydb
  docker run -d --network app-net --name web myapp
```


- **Host Network (Linux only)**
```shell script
docker run --network host myapp
```


---

## Image Sharing

- **Tag & Push**
```shell script
docker tag myapp:latest myrepo/myapp:v1
  docker push myrepo/myapp:v1
```


- **Pull**
```shell script
docker pull myrepo/myapp:v1
```


---

## Docker Compose

Define multi-container apps in `docker-compose.yml`:

```yaml
version: "3.8"
services:
  web:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - db
  db:
    image: postgres:15
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```


Commands:

```shell script
docker-compose up -d
docker-compose logs -f
docker-compose down
```


---

## Best Practices

- Keep images small: use slim or alpine base images.
- Leverage multi-stage builds to separate build and runtime.
- Pin image versions to avoid surprises.
- Clean up unused images and containers regularly (`docker system prune`).
- Store secrets securely (avoid `ENV` for sensitive data; use Docker secrets or Vault).

---

# Further Reading

- Docker documentation: https://docs.docker.com
- “Docker Up & Running” by O’Reilly
- Official Docker samples and labs on GitHub