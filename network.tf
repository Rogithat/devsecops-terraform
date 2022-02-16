module "vpc" {
 source  = "terraform-google-modules/network/google//modules/vpc"
 version = "~> 3.1.1"
 project_id   = var.project_id
 network_name = var.subnetwork

 shared_vpc_host = false
}


module "vpc_subnet" {
  source  = "terraform-google-modules/network/google//modules/subnets-beta"
  version = "~> 3.1.1"

  project_id   = var.project_id
  network_name = var.subnetwork

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.100.0.0/24"
      subnet_region = "${var.region}"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "10.191.1.0/24"
      },
      {
        range_name    = "subnet-01-secondary-02"
        ip_cidr_range = "10.192.2.0/24"
      },
      {
        range_name    = "subnet-01-secondary-02"
        ip_cidr_range = "10.193.3.0/24"
      },
    ]

    subnet-02 = []
  }
}
###