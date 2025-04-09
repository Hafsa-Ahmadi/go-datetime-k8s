#!/bin/bash
# Script to install and run Kubescape to scan for security issues

echo "Installing and running Kubescape..."

# Install Kubescape
echo "Installing Kubescape..."
curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash

# Verify installation
echo "Verifying Kubescape installation..."
kubescape version

# Scan all namespaces and save results to JSON file
echo "Scanning all namespaces..."
kubescape scan --format json --output k8s-findings.json

# Scan just the test-apps namespace
echo "Scanning the test-apps namespace specifically..."
kubescape scan --include-namespaces test-apps --format json --output test-apps-findings.json

# Summarize findings
echo "Scan complete. Findings saved to k8s-findings.json and test-apps-findings.json"
echo "Summarizing findings for test-apps namespace:"
echo "--------------------------------------------"
kubescape scan --include-namespaces test-apps --verbose

echo "Review the JSON files for detailed findings. You can also run specific framework scans with:"
echo "kubescape scan framework nsa --include-namespaces test-apps"