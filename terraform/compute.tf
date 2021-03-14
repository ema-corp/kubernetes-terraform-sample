resource "google_compute_global_address" "gke" {
  name = "${var.project_name}-global-ip"
}

resource "google_compute_network" "gke" {
  name                            = "${var.project_name}-gke-vpc"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = "true"
  delete_default_routes_on_create = "false"
}
