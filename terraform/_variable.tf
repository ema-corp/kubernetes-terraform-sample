# all

variable "project_id" {}
variable "project_name" {}
variable "gcp_key_path" {}

# gke

variable "region" {}
variable "zone" {}
variable "network" {}
variable "initial_node_count" {}
variable "description" {}
variable "min_master_version" {}
variable "node_version" {}
variable "machine_type" {}
variable "disk_size" {}
variable "gke_cidr_block" {}

# local

locals {
  ws = "${terraform.workspace}"
}
