# Setup Kubernetes cluster with Kubeadm (Terraform & Ansible).

#### What is Kubernetes?
> ***[Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)*** atau biasa disingkat ***k8s*** adalah sebuah perangkat open-source yang digunakan untuk melakukan manajemen workload pada aplikasi yang di-kontainerisasi, serta juga memberikan kemudahan untuk melakukan konfigurasi dan otomatisasi secara deklaratif.   

#### Goals:
> Tujuan dari pengerjaan ini adalah untuk melakukan instalasi kubernetes cluster menggunakan kubeadm, dimana untuk instalasi ataupun penginstalan semua dependensi akan dipermudah menggunakan [ansible](https://docs.ansible.com/ansible/latest/index.html) dan [terraform](https://www.terraform.io/intro/index.html). Semua instalasi akan dilakukan di google cloud platform.

#### Pre-requisites:
* Terraform v0.12.9
* Ansible v2.8.2
* Credentials to access GCP
* Environment:  
> | Operating System | Roles | Specification|  
> |---|---|---|  
> | Ubuntu 16.04 LTS | Master | Ram: 8GB, Processor: 2 |
> | Ubuntu 16.04 LTS | Worker | Ram: 8GB, Processor: 2 |
> | Ubuntu 16.04 LTS | Worker | Ram: 8GB, Processor: 2 |

#### Step by step:
* Pertama sekali clone terlebih dahulu repositori.   
> `$ cd /tmp && git clone https://github.com/iv1310/k8s-the-hard-way && cd k8s-the-hard-way/kubeadm/ivan`
* Kemudian pastikan sudah memiliki kredensial untuk mengakses GCP dan file public key yang akan digunakan untuk mengakses server menggunakan SSH melalui perangkat lokal.   
> `$ ls creds.json && ls id_rsa.pub`   
* Kemudian lakukan inisiasi terhadap proyek menggunakan terraform, sehingga terraform akan mendownload plugin-plugin yang diperlukan.
> `$ terraform init .`
* Kemudian sebelum melakukan provisioning ataupun instalasi service-service pada google cloud platform, biasakan untuk memastikan apakah setiap service sudah benar.
> `$ terraform plan`
* Setelah memastikan semua service yang diinginkan sudah sesuai keinginan, lakukan instalasi.
> `$ terraform apply`
* Proses instalasi akan membutuhkan sedikit waktu, kemudian setelah selesai, kita akan melihat outputnya berubah ip public dari server-server yang telah terinstal.
> `$ terraform output`
* Kemudian setelah server telah terinstal dan dapat digunakan, tahapan selanjutnya adalah melakukan manajemen konfigurasi untuk menginstall semua dependensi kubeadm, dan menginstal kubernetes cluster menggunakan ansible. Terlebih dahulu set permission.
> `$ chmod +x ./run-playbook.sh`
* Selanjutkan jalankan script.
> `$ ./run-playbook.sh`
* Setelah script selesai dan berhasil. Silahkan cek ke dalam server yang memiliki role _master_.
> `$ ssh ubuntu@IP_Master`
* Kemudian silahkan cek nodes-nodes yang telah berhasil bergabung dengan cluster.
> `$ sudo kubectl get nodes`  
![alt text](https://github.com/iv1310/k8s-the-hard-way/blob/master/kubeadm/ivan/img/cluster_nodes.png "Cluster Nodes")
