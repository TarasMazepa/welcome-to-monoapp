variable "project" {
  description = "GCP project id the node lives in."
  type        = string
}

variable "region" {
  description = "GCP region for the node."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for the node."
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Name of the node."
  type        = string
  default     = "monoapp"
}

variable "machine_type" {
  description = "Machine type for the node."
  type        = string
  default     = "e2-micro"
}

variable "image" {
  description = "Boot image for the node."
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "tailscale_auth_key" {
  description = "Tailscale auth key used to join the node to the tailnet."
  type        = string
  sensitive   = true
}
