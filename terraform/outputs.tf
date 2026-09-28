output "instance_name" {
  description = "Name of the created node."
  value       = google_compute_instance.monoapp.name
}

output "external_ip" {
  description = "Ephemeral public IP of the node."
  value       = google_compute_instance.monoapp.network_interface[0].access_config[0].nat_ip
}
