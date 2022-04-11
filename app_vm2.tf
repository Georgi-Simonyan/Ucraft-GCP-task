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
      
    }
  }
    
}