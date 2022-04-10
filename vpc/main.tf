provider "google" {
  credentials = file("C:/Users/Geosimonyan/Downloads/ucraft-346808-a75272e6ed2c.json")
  project = "ucraft-346808"
  region = "europe-west3"
}

resource "google_compute_network" "main-vpc" {
  project                 = "ucraft-346808"
  name                    = "main-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "mgmt" {
name = "mgmt"
region = "europe-west3"
ip_cidr_range = "10.0.0.0/24"
network = google_compute_network.main-vpc.name
}

resource "google_compute_subnetwork" "app" {
name = "app"
region = "europe-west3"
ip_cidr_range = "10.1.0.0/24"
network = google_compute_network.main-vpc.name
}
