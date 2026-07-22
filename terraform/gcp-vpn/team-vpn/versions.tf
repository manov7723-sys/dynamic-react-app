terraform {
  required_version = ">= 1.4"
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.20" }
    tls    = { source = "hashicorp/tls",    version = "~> 4.0" }
  }
}

provider "google" {
  region = "us-west1"
  zone   = "us-west1-a"
}
