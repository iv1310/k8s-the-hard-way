provider "google"{
  credentials="${file("creds.json")}"
  project="kubernetes-openshift-257509"
  region="asia-southeast1"
}
provider "ansible"{
  version = "~> 1.0.3"
}
variable "ssh_user"{
  default="ubuntu"
}
variable "ssh_pub_key_file"{
  default="id_rsa.pub"
}
data "google_compute_image" "my_image"{
  family="ubuntu-1604-lts"
  project="ubuntu-os-cloud"
}
resource "google_compute_address" "net_vm01"{
  name="ipv4-address-vm01"
}
resource "google_compute_address" "net_vm02"{
  name="ipv4-address-vm02"
}
resource "google_compute_address" "net_vm03"{
  name="ipv4-address-vm03"
}
resource "google_compute_address" "net_vm04"{
  name="ipv4-address-vm04"
}
resource "google_compute_address" "net_vm05"{
  name="ipv4-address-vm05"
}
resource "google_compute_address" "net_vm06"{
  name="ipv4-address-vm06"
}
resource "google_compute_firewall" "http_rule"{
  name="allow-http"
  source_ranges=["0.0.0.0/0"]
  network="${google_compute_network.vpc-gcp.name}"
  allow{
    protocol="tcp"
    ports=["80","8080"]
  }
  source_tags=["web"]
}
resource "google_compute_firewall" "ssh_rule"{
  name="allow-ssh"
  network="${google_compute_network.vpc-gcp.name}"
  allow{
    protocol="icmp"
  }
  allow{
    protocol="tcp"
    ports=["22"]
  }
}
resource "google_compute_firewall" "internal_rule"{
  name="allow-internal-network"
  network="${google_compute_network.vpc-gcp.name}"
  source_ranges=["10.148.0.0/16"]
  allow{
    protocol="icmp"
  }
  allow{
    protocol="tcp"
    ports=["0-65535"]
  }
  allow{
    protocol="udp"
    ports=["0-65535"]
  }
}
resource "google_compute_network" "vpc-gcp"{
  name="vpc-gcp"
}
resource "google_compute_instance" "controller-01"{
  name="controller-01"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  tags=["foo","bar"]
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm01.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
  service_account{
    scopes=["userinfo-email","compute-ro","storage-ro"]
  }
}
resource "google_compute_instance" "controller-02"{
  name="controller-02"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm02.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
  metadata_startup_script="echo hi > /test.txt"
}
resource "google_compute_instance" "controller-03"{
  name="controller-03"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm03.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}
resource "google_compute_instance" "worker-01"{
  name="worker-01"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm04.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
    pod-cidr="10.200.2.0/24"
  }
}
resource "google_compute_instance" "worker-02"{
  name="worker-02"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm05.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
    pod-cidr="10.200.3.0/24"
  }
}
resource "google_compute_instance" "worker-03"{
  name="worker-03"
  machine_type="n1-standard-2"
  zone="asia-southeast1-a"
  boot_disk{
    initialize_params{
      image="${data.google_compute_image.my_image.self_link}"
      size="20"
    }
    auto_delete="true"
  }
  network_interface{
    network="${google_compute_network.vpc-gcp.name}"
    access_config{
      nat_ip="${google_compute_address.net_vm06.address}"
    }
  }
  metadata={
    ssh-keys="${var.ssh_user}:${file(var.ssh_pub_key_file)}"
    pod-cidr="10.200.4.0/24"
  }
}
resource "ansible_host" "vm01"{
  inventory_hostname = "${google_compute_address.net_vm01.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm02"{
  inventory_hostname = "${google_compute_address.net_vm02.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm03"{
  inventory_hostname = "${google_compute_address.net_vm03.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm04"{
  inventory_hostname = "${google_compute_address.net_vm04.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm05"{
  inventory_hostname = "${google_compute_address.net_vm05.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm06"{
  inventory_hostname = "${google_compute_address.net_vm06.address}"
  groups = ["vm"]
  vars = {
    ansible_user = "ubuntu"
  }
}
output "vm01_public_ip"{
  value = "${google_compute_address.net_vm01.address}"
}
output "vm02_public_ip"{
  value = "${google_compute_address.net_vm02.address}"
}
output "vm03_public_ip"{
  value = "${google_compute_address.net_vm03.address}"
}
output "vm04_public_ip"{
  value = "${google_compute_address.net_vm04.address}"
}
output "vm05_public_ip"{
  value = "${google_compute_address.net_vm05.address}"
}
output "vm06_public_ip"{
  value = "${google_compute_address.net_vm06.address}"
}
