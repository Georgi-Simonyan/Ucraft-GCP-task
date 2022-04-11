terraform {
  required_providers {
    google = {
      source = "hashicorp/googl"
      version = "4.16.0"
    }
  }
}

provider "google" {
  credentials = file("~/Downloads/ucraft-346808-a75272e6ed2c.json")
  project = var.project_id
  region = var.gcp_region
}