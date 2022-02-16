module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.1.1"

  project_id   = var.project_id
  network_name = var.subnetwork

  shared_vpc_host = false
}


module "vpc_subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets-beta"
  version = "~> 3.1.1"

  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.100.0.0/21"
      subnet_region = "${var.region}"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "10.100.1.0/24"
      },
      {
        range_name    = "subnet-01-secondary-02"
        ip_cidr_range = "10.100.2.0/24"
      },
      {
        range_name    = "subnet-01-secondary-02"
        ip_cidr_range = "10.100.3.0/24"
      },
    ]

    subnet-02 = []
  }
}
###