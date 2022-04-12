#Static public ip 
resource "google_compute_address" "static_ip_app2" {
  name = "juice-shop-1"
  address = "34.159.119.155"
}
#Static private ip
resource "google_compute_address" "static_internal_ip_app2" {
  name = "juice-shop-1-internal"
  subnetwork = "app"
  address_type = "INTERNAL"
  address = "10.0.0.36"
}
# Creating instance with network and firewall rules assinged
resource "google_compute_instance" "juice-shop-1" {
  name         = "juice-shop-1"
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
      nat_ip = google_compute_address.static_ip_app2.address
    }
  }
  #installing ansible on startup
  metadata_startup_script = "sudo yum install ansible -y"

}