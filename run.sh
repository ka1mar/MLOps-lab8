#!/bin/bash

# Load environment variables
set -a
source .env
set +a

# Apply configuration directly with envsubst if available, or use alternative
if command -v envsubst &> /dev/null; then
  envsubst < k8s-setup.yml | kubectl apply -f -
else
  # Simple replacement for environments without envsubst
  sed \
    -e "s/\${MYSQL_ROOT_PASSWORD}/$MYSQL_ROOT_PASSWORD/g" \
    -e "s/\${MYSQL_DATABASE}/$MYSQL_DATABASE/g" \
    -e "s/\${MYSQL_USER}/$MYSQL_USER/g" \
    -e "s/\${MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" \
    -e "s/\${FILE_NAME}/$FILE_NAME/g" \
    -e "s/\${SPARK_DAEMON_MEMORY}/$SPARK_DAEMON_MEMORY/g" \
    -e "s/\${SPARK_DRIVER_MEMORY}/$SPARK_DRIVER_MEMORY/g" \
    -e "s/\${SPARK_WORKER_CORES}/$SPARK_WORKER_CORES/g" \
    -e "s/\${SPARK_WORKER_MEMORY}/$SPARK_WORKER_MEMORY/g" \
    k8s-setup.yml | kubectl apply -f -
fi

# Wait for MySQL
echo "Waiting for MySQL..."
kubectl -n foodfacts wait --for=condition=ready pod -l app=mysql --timeout=300s

# Initialize database
echo "Initializing database..."
MYSQL_POD=$(kubectl -n foodfacts get pod -l app=mysql -o jsonpath='{.items[0].metadata.name}')
kubectl -n foodfacts cp ./init_scripts/init.sh $MYSQL_POD:/tmp/init.sh
kubectl -n foodfacts exec $MYSQL_POD -- chmod +x /tmp/init.sh
kubectl -n foodfacts exec $MYSQL_POD -- /tmp/init.sh

# Wait for Spark Master
echo "Waiting for Spark Master..."
kubectl -n foodfacts wait --for=condition=ready pod -l app=spark-master --timeout=300s

# Run job
echo "Starting clustering job..."
kubectl -n foodfacts delete job clustering-job --ignore-not-found
kubectl apply -f <(sed \
    -e "s/\${MYSQL_DATABASE}/$MYSQL_DATABASE/g" \
    -e "s/\${MYSQL_USER}/$MYSQL_USER/g" \
    -e "s/\${MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" \
    k8s-setup.yml) -n foodfacts

# Show status
kubectl -n foodfacts get jobs
