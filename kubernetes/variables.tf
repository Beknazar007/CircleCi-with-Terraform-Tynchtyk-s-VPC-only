#===========================CONTAINER CLUSTER VARIABLES======================================

variable "cluster_name" {
   description = "The name of the cluster"
   type = string
   default = "preview-deploys"
}

# variable "project" {
#   description = "The project ID where the cluster will be create"
#   type = string
# }

variable "location" {
  description = "The location (region or zone) where the cluster will be create"
  type = string
  default = "us-central1-b"
}

variable "network" {
  description = "A reference (self link) to the VPC network to host the cluster in"
  type = string
}

variable "subnetwork" {
  description = "A reference (self link) to the subnetwork to host the cluster in"
  type = string
}

variable "node_locations" {
  description = "The locations of created nodes"
  type = list
  default = [
      "us-central1-c",
      "us-central1-a"
  ]
}


variable "gke_version" {
  type = string
  default = "1.21"
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool"
  type = number
  default = 1
}

variable "remove_default_pool" {
  description = "If <true>, deletes the default node pool upon cluster creation"
  type = bool
  default = true
}

variable "client_certificate_config" {
  
  type = bool
  default = false
}

variable "maintenance_start_time" {
  type = string
  default = "03:00"
}

#===================CONTAINER NODE POOL VARIABLES======================================

variable "node_pool_name" {
  description = "The name of node pool"
  type = string
  default = "preview-deploys"
}

variable "node_count" {
  description = "The initial number of nodes for the pool."
  type = number
  default = 2
}


variable "min_node_count" {
  description = "Minimum number of nodes in the NodePool for autoscaling."
  type = number
  default = 3
}

variable "max_node_count" {
  description = "Maximum number of nodes in the NodePool for autoscaling."
  type = number
  default = 15
}

variable "auto_repair" {
  description = "Whether the nodes will be automatically repaired."
  type = bool
  default = true
}

variable "auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded."
  type = bool
  default = false
}

variable "machine_type" {
  description = "The machine type to create."
  type = string
  default = "n1-standard-8"
}


variable "oauth_scopes" {
  description = "Scopes that are used by NAP when creating node pools."
  type = list
  default = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/cloud-platform",
  ]
}

variable "app_tags" {
  description = "Map of lists containing node network tags by node-pool name"
  type = list(string)
  default = ["app"]
}