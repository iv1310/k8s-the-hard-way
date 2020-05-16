<a name="kubernetes"></a>
# Kubernetes
*is an open-source system for automating deployment, scaling, and management of containerized applications.*
<p align="center"><img src="https://d33wubrfki0l68.cloudfront.net/69e55f968a6f44613384615c6a78b881bfe28bd6/42cd3/_common-resources/images/flower.svg" title="kubernetes flow" alt="kubernetes flow"></p>

## Table of Contents
* [About](#kubernetes)
* [Usage](#usage)
* [Requirement](#requirement)
* [Installation](#installation)
* [Kubernetes Cluster](#kubernetesCluster)
* [Prometheus](#prometheus)
* [Conclusion](#conclusion)

<a name="usage"></a>
## Usage

<a name="requirement"></a>
## Requirement
The **[recommended](https://docs.kublr.com/installation/hardware-recommendation/)** kubernetes cluster hardware requirements is :
> | Role | Minimum memory | Minimum CPU Cores | Components |
> | --- | --- | --- | --- |
> | Master Node | 2 GB | 1.5 | Kublr-Kubernetes master components (k8s-core, cert-updater, fluentd, kube-addon-manager, rescheduler, network, etcd, proxy, kubelet) |
> | Worker Node | 700 mB | 0.5 | Kublr-Kubernetes worker components (fluentd, dns, proxy, network, kubelet) |
> | Centralized Monitoring Agent* | 2 GB | 0.7 | Prometheus. We recommend limit 2GB for typical installation of managed cluster which has 8 working, 40 pods per node with total 320 nodes. Retention period for prometheus agent is 1 hour. |
*\*IF NEEDED*

### Docker
<p align="center"><img src="https://www.shadowandy.net/wp/wp-content/uploads/docker.png"></p>
a set of **platform as a service** (PaaS) products that uses OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels. All containers are run by a single operating system kernel and therefore use fewer resources than virtual machines.


<a name="installation"></a>
## Installation

<a name="kubernetesCluster"></a>
## Kubernetes Cluster
<p align="center"><img src="https://d33wubrfki0l68.cloudfront.net/99d9808dcbf2880a996ed50d308a186b5900cec9/40b94/docs/tutorials/kubernetes-basics/public/images/module_01_cluster.svg" title="cluster" alt="cluster"></p>

### Master

### Worker

<a name="prometheus"></a>
## Prometheus
<p align="center"><img src="https://steiniche.net/wp-content/uploads/2018/03/prometheus_logo.png"></p>

<a name="conclusion"></a>
## Conclusion
