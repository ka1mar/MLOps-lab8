#!/bin/bash

# Clean up previous resources
kubectl delete -f k8s-job.yml --ignore-not-found
kubectl delete -f k8s-setup.yml --ignore-not-found
kubectl delete -f k8s-config.yml --ignore-not-found

# Apply configuration
kubectl apply -f k8s-config.yml
kubectl apply -f k8s-setup.yml

# Wait for MySQL
echo "Waiting for MySQL to start..."
kubectl -n foodfacts wait --for=condition=ready pod -l app=mysql --timeout=300s

# Initialize database
echo "Initializing database..."
MYSQL_POD=$(kubectl -n foodfacts get pod -l app=mysql -o jsonpath='{.items[0].metadata.name}')
kubectl -n foodfacts cp ./init_scripts/init.sh $MYSQL_POD:/tmp/init.sh
kubectl -n foodfacts exec $MYSQL_POD -- chmod +x /tmp/init.sh
kubectl -n foodfacts exec $MYSQL_POD -- /tmp/init.sh

# Wait for Spark Master
echo "Waiting for Spark Master to start..."
kubectl -n foodfacts wait --for=condition=ready pod -l app=spark-master --timeout=300s

# Wait for Spark Worker
echo "Waiting for Spark Worker to start..."
kubectl -n foodfacts wait --for=condition=ready pod -l app=spark-worker --timeout=300s

# Run job
echo "Starting clustering job..."
kubectl apply -f k8s-job.yml

# Show status
echo -e "\nCluster status:"
kubectl -n foodfacts get all


