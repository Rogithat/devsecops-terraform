locals {
  cluster_type = "gke-labs"
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  project = var.project_id
  region  = var.region
}

module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                = "14.2.0"
  project_id             = var.project_id
  name                   = "devsecopstcc-cluster"
  regional               = true
  region                 = var.region
  network                = "vpc-devsecops"
  subnetwork             = "subnet-01"
  ip_range_pods          = "subnet-01-secondary-01"
  ip_range_services      = "subnet-01-secondary-02"
  create_service_account = false
  #service_account           = var.compute_engine_service_account
  enable_private_endpoint   = false
  enable_private_nodes      = true
  master_ipv4_cidr_block    = "172.16.3.0/28"
  default_max_pods_per_node = 100
  remove_default_node_pool  = true

  node_pools = [
    {
      name            = "pool-01"
      machine_type    = "n1-standard-2"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
      #service_account   = var.compute_engine_service_account
      preemptible       = true
      max_pods_per_node = 110
    },
  ]

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0" #data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "all_origin_access"
    },
  ]
}

data "google_client_config" "default" {
}
