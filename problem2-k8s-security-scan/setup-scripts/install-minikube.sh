#!/bin/bash
# Script to install Minikube on Linux

echo "Installing Minikube..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is required but not installed. Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo "Docker installed. You may need to log out and back in for group changes to take effect."
    echo "Please run this script again after logging back in."
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    echo "kubectl installed successfully"
fi

# Install Minikube
echo "Downloading Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Start Minikube
echo "Starting Minikube..."
minikube start --driver=docker

# Verify installation
echo "Verifying installation..."
minikube status
kubectl get nodes

echo "Minikube installation complete. Kubernetes cluster is now running."
echo "Run 'minikube dashboard' to access the Kubernetes dashboard."