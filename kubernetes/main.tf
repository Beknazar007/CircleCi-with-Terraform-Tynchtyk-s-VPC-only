resource "google_container_cluster" "preview_deploys" {
  name = var.cluster_name

#   project = var.project
  location = var.location
  network = var.network
  subnetwork = var.subnetwork

  node_locations = var.node_locations

  min_master_version = var.gke_version
  initial_node_count = var.initial_node_count
  remove_default_node_pool = var.remove_default_pool

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = var.client_certificate_config  
    }
  }

  maintenance_policy {
    daily_maintenance_window {
        start_time = var.maintenance_start_time
    }
  }
}

resource "google_container_node_pool" "preview_deploys" {
  name = var.node_pool_name
#   project = var.project
  location = var.location
  cluster = google_container_cluster.preview_deploys.name
  initial_node_count = var.node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoint = "true"
    }

    oauth_scopes = var.oauth_scopes

    tags = var.app_tags
  }
  
}