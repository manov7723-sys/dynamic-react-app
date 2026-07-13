terraform {
  required_version = ">= 1.5.0"
  backend "gcs" {
    bucket = "agent-bucket-gcp"
    prefix = "gke/dev"
  }
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
  }
}

provider "google" {
  project = "new-project-495604"
  region  = "us-central1"
}
