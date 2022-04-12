resource "google_compute_firewall" "bastion_fw" {
  name    = "bastion-firewall"
  network = google_compute_network.main-vpc.name 
  source_ranges = ["37.252.82.156/32"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
    
    target_tags = ["bastion", "ssh"]
}