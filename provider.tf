provider "google" {
  #version     = "~> 3.16.0"
  credentials = file("creds/serviceaccount.json")
  project     = var.project_id
}

provider "google-beta" {
  #version     = "~> 3.16.0"
  credentials = file("creds/serviceaccount.json")
  project     = var.project_id
}