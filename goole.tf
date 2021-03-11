provider "google" {
 credentials = file("graphic-centaur-302312-9c92a9be897b.json")
 project = "{{graphic-centaur-302312}}"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "vm_instance"  {
  metadata = {
    ssh-keys = "BUH-d072:${file("~/.ssh/id_rsa.pub")}"
    }
  name         = "terraform-instance"
  machine_type = "e2-small"
  boot_disk {
    initialize_params {
      image = "Ubuntu 20.04"
    }
  }
 network_interface {
   network = "default"

   access_config {
}
}
}
