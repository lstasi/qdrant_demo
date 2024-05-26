
resource "google_compute_network" "vpc" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
}

resource "google_container_cluster" "gke" {
  name     = var.name
  location = var.gcp_region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  initial_node_count = var.node_count

  deletion_protection = false

  node_config {
    machine_type = "e2-medium"
  }
}