terraform {
  backend "gcs" {
    bucket      = "tf-state-gke-devsecops"
    prefix      = "terraform-devsecops/state"
    credentials = "creds/serviceaccount.json"
  }
}