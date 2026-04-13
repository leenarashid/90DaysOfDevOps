#!/bin/bash
# health-check.sh
# Pulls the Docker image, runs it, curls the health endpoint, and prints PASS or FAIL.

IMAGE_NAME="${1:-github-actions-capstone:latest}"
PORT=8080
CONTAINER_NAME="healthcheck_temp"

echo "==> Pulling image: $IMAGE_NAME"
docker pull "$IMAGE_NAME"

echo "==> Starting container..."
docker run -d --name "$CONTAINER_NAME" -p "$PORT:$PORT" "$IMAGE_NAME"

echo "==> Waiting 5 seconds for the container to start..."
sleep 5

echo "==> Curling health endpoint..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:$PORT/")

echo "==> Stopping and removing container..."
docker stop "$CONTAINER_NAME" > /dev/null
docker rm "$CONTAINER_NAME" > /dev/null

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "✅ Health check PASSED — HTTP $HTTP_STATUS"
  exit 0
else
  echo "❌ Health check FAILED — HTTP $HTTP_STATUS"
  exit 1
fi
