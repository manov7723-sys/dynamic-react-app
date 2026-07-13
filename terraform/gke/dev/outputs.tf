output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value     = google_container_cluster.primary.endpoint
  sensitive = true
}

output "location" {
  value = local.location
}

output "update_kubeconfig_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --location us-central1 --project new-project-495604"
}
