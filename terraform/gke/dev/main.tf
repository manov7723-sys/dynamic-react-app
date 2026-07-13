locals {
  cluster_name = "dev"
  location     = "us-central1"
  labels = {
    managed_by  = "deepagent"
    cluster     = local.cluster_name
    environment = "production"
    team        = "devops"
  }
}

# Reusing existing network "default".
locals {
  network    = "default"
  subnetwork = "default"
}

# Regional cluster with the default node pool removed so the node pools below
# are the single source of truth (manageable size, autoscaling, taints).
resource "google_container_cluster" "primary" {
  name     = local.cluster_name
  location = local.location

  remove_default_node_pool = true
  initial_node_count       = 1

  min_master_version = "1.36"

  network    = local.network
  subnetwork = local.subnetwork

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  release_channel {
    channel = "REGULAR"
  }

  datapath_provider = "ADVANCED_DATAPATH"

  workload_identity_config {
    workload_pool = "new-project-495604.svc.id.goog"
  }

  enable_shielded_nodes = true

  enable_intranode_visibility = true

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gke_backup_agent_config {
      enabled = true
    }
  }

  resource_labels = local.labels
}

resource "google_container_node_pool" "system_nodes" {
  name     = "${local.cluster_name}-system"
  location = local.location
  cluster  = google_container_cluster.primary.name

  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

    node_config {
      machine_type = "n2-standard-4"
      image_type   = "COS_CONTAINERD"
      disk_type    = "pd-ssd"
      disk_size_gb = 100
      oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
      labels = {
        role = "system"
        env  = "production"
      }
      taint {
        key    = "CriticalAddonsOnly"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
      shielded_instance_config {
        enable_secure_boot          = true
        enable_integrity_monitoring = true
      }
      workload_metadata_config {
        mode = "GKE_METADATA"
      }
    }
}

resource "google_container_node_pool" "app_nodes" {
  name     = "${local.cluster_name}-app"
  location = local.location
  cluster  = google_container_cluster.primary.name

  autoscaling {
    min_node_count = 2
    max_node_count = 10
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

    node_config {
      machine_type = "e2-medium"
      image_type   = "COS_CONTAINERD"
      disk_type    = "pd-ssd"
      disk_size_gb = 100
      spot         = true
      oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
      labels = {
        role = "application"
        env  = "production"
      }
      shielded_instance_config {
        enable_secure_boot          = true
        enable_integrity_monitoring = true
      }
      workload_metadata_config {
        mode = "GKE_METADATA"
      }
    }
}
