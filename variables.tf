variable "project_id" {
  description = "The project ID to host the cluster in"
  default = "tcc-devsecops"
}

variable "subnetwork" {
  description = "subnetwork usada pelo gke"
  default = "vpc-devsecops"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-east1"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  default     = "gke-cluster-pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  default     = "gke-cluster-services"
}

variable "terraform_service_account" {
  type        = string
  default     = "terraform-sa@tcc-devsecops.iam.gserviceaccount.com"
  description = "Service account que será utilizada para executar o Terraform (via impersonate)."
}
