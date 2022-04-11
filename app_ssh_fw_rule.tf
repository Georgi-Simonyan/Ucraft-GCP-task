resource "google_compute_firewall" "app_fw" {
  name    = "ssh-firewall"
  network = google_compute_network.main-vpc.name 
  source_ranges = [var.cidr_mgmt]
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["https"]
}