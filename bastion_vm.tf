resource "google_compute_address" "static_ip_bastion" {
  name = "bastion-vm"
}
resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-medium"
  zone = var.gcp_zone

  tags = ["bastion", "ssh"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    subnetwork = "mgmt"
    access_config {
      nat_ip = google_compute_address.static_ip_bastion.address
    }
  }

  metadata_startup_script = "yum install ansible -y"
}