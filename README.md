# python-app

`python-app` is a lightweight Flask service that exposes simple operational APIs and is designed for containerized deployment to Kubernetes.

## What it does

The application provides two HTTP endpoints:

- `GET /api/v1/details` — returns the current server time and container hostname.
- `GET /api/v1/healthz` — returns a health response (`{"status": "up"}`) for readiness/liveness checks.

## Project structure

- `/src` — Flask application source code.
- `/docs` — MkDocs/TechDocs content.
- `/k8s` — raw Kubernetes manifests (Deployment, Service, Ingress).
- `/charts/python-app` — Helm chart for deploying the app.
- `/.github/workflows/cicd.yaml` — CI/CD workflow for building Docker images and syncing deployment.

## Tech stack

- Python 3 + Flask
- Docker
- Kubernetes + Helm
- GitHub Actions + Argo CD

## Run locally

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Start the app:
   ```bash
   python src/app.py
   ```
3. Access the service at `http://localhost:5000`.

## Container image

The Dockerfile:

- uses `python:3.10-alpine`
- installs dependencies from `requirements.txt`
- copies source from `/src`
- starts the app with `python /src/app.py`

## Deployment

You can deploy this service either by:

- applying manifests from `/k8s`, or
- using the Helm chart in `/charts/python-app`.

The default ingress host in chart values is `python-app.test.com`, and health probes target `/api/v1/healthz`.

## CI/CD overview

The GitHub Actions workflow:

1. builds and pushes a Docker image on pushes to `main` when `src/**` changes,
2. updates the Helm values image tag,
3. triggers Argo CD sync for the `python-app` application.
