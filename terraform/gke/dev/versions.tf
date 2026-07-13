terraform {
  required_version = ">= 1.5.0"
  # No GCS backend configured — state is local. Create a GCS bucket and
  # set it as the state bucket for production use.
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
  }
}

provider "google" {
  project = "new-project-495604"
  region  = "us-central1"
}
