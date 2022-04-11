resource "google_compute_firewall" "bastion_fw" {
  name    = "bastion-firewall"
  network = google_compute_network.main-vpc.name 
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
    
    target_tags = ["bastion", "ssh"]
}