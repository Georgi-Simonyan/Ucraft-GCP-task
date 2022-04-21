#Static public ip 
resource "google_compute_address" "static_ip_app1" {
  name = "juice-shop-0"
  address = "34.159.39.116"
}
#Static private ip
resource "google_compute_address" "static_internal_ip_app1" {
  name = "juice-shop-0-internal"
  subnetwork = "app"
  address_type = "INTERNAL"
  address = "10.0.0.37"
}

# Creating instance with network and firewall rules assinged
resource "google_compute_instance" "juice-shop-0" {
  name         = "juice-shop-0"
  machine_type = "e2-medium"
  zone = var.gcp_zone

  tags = ["https"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    subnetwork = "app"
    access_config {
      nat_ip = google_compute_address.static_ip_app1.address
    }
  }
  #installing ansible on startup
  metadata_startup_script = "sudo yum install ansible -y" 
}