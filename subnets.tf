resource "google_compute_subnetwork" "mgmt" {
  name = "mgmt"
  ip_cidr_range = var.cidr_mgmt
  network = google_compute_network.main-vpc.name
}

resource "google_compute_subnetwork" "app" {
  name = "app"
  ip_cidr_range = var.cidr_app
  network = google_compute_network.main-vpc.name
}
