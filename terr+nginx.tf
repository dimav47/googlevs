terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.59.0"
    }
  }
}

provider "google" {
  credentials = file("Project-450fbf6389c5.json")
  project = "graphic-centaur-302312"
  region  = "us-central1"
  zone    = "us-central1-a"
  user_project_override = true
}

resource "google_compute_instance" "vm-instance"  {
  metadata = {
    ssh-keys = "BUH-d072:${file("~/.ssh/id_rsa.pub")}"
    }
  name         = "terraform-nginx"
  machine_type = "e2-small"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      size = "15"
      type = "pd-balanced"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
 network_interface {
   network = "default"

   access_config {
    }
  }

provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install default-jre -y",
      "sudo apt install nginx -y",
    ]
    connection {
      type     = "ssh"
      user     = "buh-d072"
      private_key = file("/root/.ssh/id_rsa")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/var/www/html/index.html"
    connection {
      type     = "ssh"
      user     = "buh-d072"
      private_key = file("/root/.ssh/id_rsa")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}

