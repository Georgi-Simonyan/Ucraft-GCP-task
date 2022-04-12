resource "google_compute_address" "static_ip_bastion" {
  name = "bastion-vm"
  address = "35.246.207.173"
}
resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-medium"
  zone = var.gcp_zone

  tags = ["bastion", "ssh"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    subnetwork = "mgmt"
    access_config {
      nat_ip = google_compute_address.static_ip_bastion.address
    }
  }

  metadata_startup_script = "${file("startup.sh")}"
# provisioner "remote-exec" {
#     inline = ["echo 'Wait until SSH is ready'"]

#     connection {
#       type        = "ssh"
#       user        = var.ssh_user
#       private_key = file(var.private_key_path)
#       host        = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
#     }
#   }

#   provisioner "local-exec" {
#     command = "ansible-playbook  -i ${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}, --private-key ${var.private_key_path} nginx.yaml"
#   }
}
