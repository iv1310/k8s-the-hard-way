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
  default="ivan.pub"
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
resource "google_compute_instance" "vm01"{
  name="k8s-master"
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
resource "google_compute_instance" "vm02"{
  name="k8s-node01"
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
resource "google_compute_instance" "vm03"{
  name="k8s-node02"
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
resource "ansible_host" "vm01"{
  inventory_hostname = "${google_compute_address.net_vm01.address}"
  groups = ["k8s-master"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm02"{
  inventory_hostname = "${google_compute_address.net_vm02.address}"
  groups = ["k8s-node"]
  vars = {
    ansible_user = "ubuntu"
  }
}
resource "ansible_host" "vm03"{
  inventory_hostname = "${google_compute_address.net_vm03.address}"
  groups = ["k8s-node"]
  vars = {
    ansible_user = "ubuntu"
  }
}
