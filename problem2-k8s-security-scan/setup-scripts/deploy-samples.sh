#!/bin/bash
# Script to deploy sample workloads with security issues

echo "Deploying sample workloads with security issues..."

# Create a namespace for our test applications
kubectl create namespace test-apps

# Deploy NGINX with security issues (privileged container)
echo "Deploying NGINX with privileged container..."
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: test-apps
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        securityContext:
          privileged: true
        # Missing resource limits
EOF

# Deploy pod with excessive capabilities
echo "Deploying pod with excessive capabilities..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
  namespace: test-apps
spec:
  containers:
  - name: security-context-demo
    image: busybox:latest
    command: ["sh", "-c", "sleep 1h"]
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME", "SYS_ADMIN"]
EOF

# Deploy pod with hostPath volume mount
echo "Deploying pod with hostPath volume mount..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-volume-pod
  namespace: test-apps
spec:
  containers:
  - name: volume-test
    image: busybox:latest
    command: ["sh", "-c", "sleep 1h"]
    volumeMounts:
    - mountPath: /host-data
      name: hostpath-volume
  volumes:
  - name: hostpath-volume
    hostPath:
      path: /
      type: Directory
EOF

# Deploy pod with secrets as environment variables
echo "Deploying pod with secrets as environment variables..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: example-secret
  namespace: test-apps
type: Opaque
stringData:
  db-password: "supersecretpassword123"
  api-key: "api_key_12345"
---
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
  namespace: test-apps
spec:
  containers:
  - name: secret-env-container
    image: busybox:latest
    command: ["sh", "-c", "sleep 1h"]
    env:
    - name: DATABASE_PASSWORD
      valueFrom:
        secretKeyRef:
          name: example-secret
          key: db-password
    - name: API_KEY
      valueFrom:
        secretKeyRef:
          name: example-secret
          key: api-key
EOF

# Verify deployments
echo "Verifying deployments..."
kubectl get all -n test-apps

echo "Sample workloads deployed successfully. Run the Kubescape scan to identify security issues."