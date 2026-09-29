terraform {
  required_version = ">= 1.5"

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
    network = "default"

    # Ephemeral public IP: only used so the node can reach the internet to
    # install Tailscale and join the tailnet. Access happens over Tailscale.
    access_config {}
  }

  metadata = {
    tailscale-auth-key = var.tailscale_auth_key
  }

  metadata_startup_script = file("${path.module}/startup.sh")
}
