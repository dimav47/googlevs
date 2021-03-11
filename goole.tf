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
  name         = "terraform-instance"
  machine_type = "e2-small"
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
}
