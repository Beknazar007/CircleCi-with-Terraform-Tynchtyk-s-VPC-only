provider "google" {
  project = "playground-s-11-e26b5c80"
  region = "us-central1"
  zone = "us-centrall1-c"

  credentials = file("playground-s-11-e26b5c80-2ceb4ad04ed2.json")
}

# module "gke" {
#   source = "../kubernetes"
#   network = module.network.vpc_name
#   subnetwork = module.network.subnetwork_name
#   machine_type = "g1-small"
# }

module "network" {
  source = "./network"
  delete_default_routes_on_create = true


#==========================SUBNETS=============================
  subnets = [
    {
      subnet_name = "presentation-subnet"
      subnet_ip_range = var.presentation_ip_range
      subnet_region = "us-central1"
    },
    {
      subnet_name = "application-subnet"
      subnet_ip_range = var.application_ip_range
      subnet_region = "us-central1"
      subnet_private_access = true
    },
    {
      subnet_name = "database-subnet"
      subnet_ip_range = var.database_ip_range
      subnet_region = "us-central1"
      subnet_private_access = true
    },

  ]
  
#============================ROUTES=============================

  routes = [
    {
      name = "igw-route"
      destination_range = var.igw_destination
      tags = "public"
      next_hop_internet = "true"
    }
  ]

#=========================FIREWALL-RULES========================
  firewall_rules = [
  {
    name = "presentation-firewall-rule"
    direction = "INGRESS"
    ranges = var.presentation_firewall_ranges
    target_tags = ["public"]
    source_tags = null

    allow = [ {
      protocol = "all"
      ports = null
    }]
    deny = []
  },
  {
    name = "application-firewall-rule"
    direction = "INGRESS"
    ranges = var.application_firewall_ranges
    target_tags = ["application"]
    source_tags = null

    allow = [{
      protocol = "all"
      ports = null
    }]
    deny = []
    
  },
  {
    name = "database-firewall-rule"
    direction = "INGRESS"
    ranges = var.database_firewall_ranges
    source_tags = null
    target_tags = ["database"]

    allow = [{
      protocol = "all"
      ports = null
    }]
    deny = []
  }
]
}

