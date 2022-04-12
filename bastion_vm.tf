# Applying static public ip address to bastion vm
resource "google_compute_address" "static_ip_bastion" {
  name = "bastion-vm"
  address = "35.246.207.173"
}

resource "google_compute_address" "static_internal_ip_bastion" {
  name = "bastion"
  subnetwork = "mgmt"
  address_type = "INTERNAL"
  address = "10.0.0.8"
}

# Creating bastion instance
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
  # Assigning to subnet 
  network_interface {
    subnetwork = "mgmt"
    access_config {
      nat_ip = google_compute_address.static_ip_bastion.address
    }
  }

  # Runing script on startup
  metadata_startup_script = "sudo yum install ansible -y"

  # Cheking ssh connection
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = google_compute_address.static_ip_bastion.address
    }
  }

  # Copying ansible files to bastion
  provisioner "local-exec" {
    command = "scp -i ${var.private_key_path} -o StrictHostKeyChecking=no -r ./ansible/ ${var.ssh_user}@${google_compute_address.static_ip_bastion.address}:/home/ansible/"
    
  }
  # Removing old configuration files and replacing by new once
  # provisioner "local-exec" {
  #   command = "ssh -i ${var.private_key_path} ${var.ssh_user}@${google_compute_address.static_ip_bastion.address} 'sudo rm -rf /etc/ansible/* && sudo cp -rf ansible/* /etc/ansible/ ' "
  # }

  
}