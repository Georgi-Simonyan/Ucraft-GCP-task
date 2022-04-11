resource "google_compute_firewall" "app_https_fw" {
  name    = "https-firewall"
  network = google_compute_network.main-vpc.name 
  source_ranges = ["0.0.0.0/0"]
  
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags = ["https"]
}