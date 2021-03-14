resource "google_container_cluster" "gke" {
  name                     = "${var.project_name}"
  location                 = "${var.zone}"
  network                  = "${google_compute_network.gke.self_link}"
  initial_node_count       = "${var.initial_node_count}"
  remove_default_node_pool = true
  description              = "${var.description}"

  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  ip_allocation_policy {
    use_ip_aliases           = true
    cluster_ipv4_cidr_block  = "${cidrsubnet(var.gke_cidr_block, 4, 1)}"
    services_ipv4_cidr_block = "${cidrsubnet(var.gke_cidr_block, 4, 2)}"
  }
}

resource "google_container_node_pool" "gke" {
  name       = "${var.project_name}-node-pool"
  location   = "${var.zone}"
  cluster    = "${google_container_cluster.gke.name}"
  node_count = "${var.initial_node_count}"

  autoscaling {
    max_node_count = 2
    min_node_count = 1
  }

  node_config {
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size}"
    preemptible  = false

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}
