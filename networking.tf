# Networking


# VPC MGMT

resource "google_compute_network" "vpc_mgmt" {
  project = var.gcp_project
  name = "${var.prefix}-vpc_mgmt"
  auto_create_subnetworks = false
  mtu = "1460"
}

resource "google_compute_subnetwork" "vpc_mgmt_sub"{
  name          = "${var.prefix}-mgmt_sub"
  ip_cidr_range = var.gcp_cidr_mgmt
  region        = var.gcp_region
  network       = google_compute_network.vpc_mgmt.id
}

# VPC LB

resource "google_compute_network" "vpc_lb" {
  name                    = "${var.prefix}-vpc_lb"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}
resource "google_compute_subnetwork" "vpc_lb_sub" {
  name          = "${var.prefix}-lb_sub"
  ip_cidr_range = var.gcp_cidr_lb
  region        = var.gcp_region
  network       = google_compute_network.vpc_lb.id
}

# VPC Internal
resource "google_compute_network" "vpc_int" {
  name                    = "${var.prefix}-vpc_int"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}
resource "google_compute_subnetwork" "vpc_int_sub" {
  name          = "${var.prefix}-int_sub"
  ip_cidr_range = var.gcp_cidr_int
  region        = var.gcp_region
  network       = google_compute_network.vpc_int.id
}


# FIREWALL RULES

resource "google_compute_firewall" "allow_int_mgmt" {
  name    = "${var.prefix}-allow_int_mgmt"
  network = google_compute_network.vpc_mgmt.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
      protocol = "udp"
      ports = ["0-65535"]
  }

  source_tags = ["sbx"]
}

resource "google_compute_firewall" "allow_int_lb" {
  name          = "${var.prefix}-allow_int_lb"
  network       = google_compute_network.vpc_lb.name
  source_ranges = [var.gcp_cidr_lb]
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "allow_int" {
  name          = "${var.prefix}-allow_int"
  network       = google_compute_network.vpc_int.name
  source_ranges = [var.gcp_cidr_int]
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "f5mgmt" {
  name          = "${var.prefix}-allow_f5mgmt"
  network       = google_compute_network.vpc_mgmt.name
  source_ranges = [var.adminSrcAddr]
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "443", "8443"]
  }
}

resource "google_compute_firewall" "app" {
  name          = "${var.prefix}-allow_app"
  network       = google_compute_network.vpc_lb.name
  source_ranges = [var.adminSrcAddr]
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}




resource "google_compute_route" "l3test_route" {
  name        = "prj-it-sbx-l3test-route"
  dest_range  = "10.83.18.0/24"
  network     = google_compute_network.l3test-vpc_network.name
  next_hop_ip = "10.83.23.1"
  priority    = 100
}
