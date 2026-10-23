terraform {
  required_version = ">= 1.5"

  # State lives in a GCS bucket instead of on one machine. The bucket name is
  # passed at init time, see the README.
  backend "gcs" {
    prefix = "server-setup-terraform-for-gcp"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# A network of its own with no firewall rules, so nothing on the internet can
# reach the node. Unlike the default network, it has no pre-made rules opening
# SSH or RDP to everyone. Tailscale only needs outgoing connections.
resource "google_compute_network" "monoapp" {
  name = var.instance_name
}

# A single small node that joins the tailnet on boot, so the monoapp server can
# be reached privately over Tailscale.
resource "google_compute_instance" "monoapp" {
  name         = var.instance_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = google_compute_network.monoapp.id

    # Ephemeral public IP: only used so the node can reach the internet to
    # install Tailscale and join the tailnet. Access happens over Tailscale.
    access_config {}
  }

  metadata = {
    tailscale-auth-key = var.tailscale_auth_key
    tailscale-tags     = var.tailscale_tags
  }

  metadata_startup_script = file("${path.module}/startup.sh")
}
