# Setup Kubernetes cluster with Kubeadm (Terraform & Ansible).

#### What is Kubernetes?
> ***[Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)*** atau biasa disingkat ***k8s*** adalah sebuah perangkat open-source yang digunakan untuk melakukan manajemen workload pada aplikasi yang di-kontainerisasi, serta juga memberikan kemudahan untuk melakukan konfigurasi dan otomatisasi secara deklaratif.   

#### Goals:
> Tujuan dari pengerjaan ini adalah untuk melakukan instalasi kubernetes cluster menggunakan kubeadm, dimana untuk instalasi ataupun penginstalan semua dependensi akan dipermudah menggunakan [ansible](https://docs.ansible.com/ansible/latest/index.html) dan [terraform](https://www.terraform.io/intro/index.html). Semua instalasi akan dilakukan di google cloud platform.

#### Pre-requisites:
* Terraform v0.12.9
* Ansible v2.8.2
* Credentials to GCP
* Environment:  
> | Operating System | Roles | Specification|  
> |---|---|---|  
> | Ubuntu 16.04 LTS | Master | Ram: 8GB, Processor: 2 |
> | Ubuntu 16.04 LTS | Worker | Ram: 8GB, Processor: 2 |
> | Ubuntu 16.04 LTS | Worker | Ram: 8GB, Processor: 2 |

#### Step by step:
* 
