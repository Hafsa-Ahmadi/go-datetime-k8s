# Kubernetes Security Scan

This solution demonstrates how to:

1. Install a local Kubernetes cluster
2. Deploy sample workloads with security issues
3. Scan the cluster using Kubescape
4. Generate a JSON file with security findings

## Contents

- [Setup Scripts](./setup-scripts/)
  - [Install Minikube](./setup-scripts/install-minikube.sh)
  - [Deploy Sample Workloads](./setup-scripts/deploy-samples.sh)
  - [Run Kubescape Scan](./setup-scripts/run-kubescape.sh)
- [Example Findings](./example-findings.json)

## Overview

The Kubernetes Security Scan solution provides a method to evaluate the security posture of a Kubernetes cluster by identifying common misconfigurations, vulnerabilities, and compliance issues. Using Kubescape, an open-source Kubernetes security tool, we scan the cluster against security frameworks like NSA-CISA, MITRE ATT&CK, and CIS Benchmarks.

## Implementation Steps

1. Install a local Kubernetes cluster using Minikube or Kind
2. Deploy sample workloads that include common security issues
3. Install and run Kubescape to scan the cluster
4. Analyze the JSON output to identify and prioritize security issues

## Security Findings Categories

The scan typically identifies issues in the following categories:

- Privileged containers
- Missing resource limits
- Excessive permissions
- Insecure configurations
- Network policy gaps
- Secrets management issues
- Host path mounts
- Improperly configured security contexts