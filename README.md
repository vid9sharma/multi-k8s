# Multi-K8s

A multi-service Kubernetes demo project featuring a React client, Node.js/Express server, worker process, and a Postgres/Redis backend. This project demonstrates containerization, orchestration, and CI/CD deployment using Docker, Kubernetes, and Travis CI.

## Project Structure

- `client/` - React frontend application
- `server/` - Node.js/Express API server
- `worker/` - Node.js worker for background processing
- `k8s/` - Kubernetes manifests for deployments and services
- `.travis.yml` - Travis CI configuration for automated testing and deployment
- `deploy.sh` - Deployment script for building, pushing, and updating images

## Prerequisites

- [Docker](https://www.docker.com/)
- [Kubernetes](https://kubernetes.io/) (local cluster or GKE)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Node.js](https://nodejs.org/)
- [Travis CI](https://travis-ci.com/) (for CI/CD)

## Getting Started

### 1. Build Docker Images

```sh
docker build -t yourdockerid/multi-client -f ./client/Dockerfile ./client
docker build -t yourdockerid/multi-server -f ./server/Dockerfile ./server
docker build -t yourdockerid/multi-worker -f ./worker/Dockerfile ./worker
```

### 2. Push Images to Docker Hub

```sh
docker push yourdockerid/multi-client
docker push yourdockerid/multi-server
docker push yourdockerid/multi-worker
```

### 3. Apply Kubernetes Configurations

```sh
kubectl apply -f k8s/
```

### 4. Set Secrets

Create a Kubernetes secret for the Postgres password:

```sh
kubectl create secret generic pgpassword --from-literal=PGPASSWORD=yourpassword
```

### 5. Access the Application

- The client is exposed via the Ingress resource.
- Update your `/etc/hosts` if needed to point a domain to your cluster.

## CI/CD

- Automated tests and deployments are managed via Travis CI.
- On push to `master`, Travis will build, test, and deploy the latest images.
