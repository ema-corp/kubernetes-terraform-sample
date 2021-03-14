provider "google" {
  credentials = "${file("${var.gcp_key_path}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

terraform {
  backend "gcs" {}
}
