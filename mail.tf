terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.68.0"
    }
  }
}

provider "yandex" {
  token     = "AQAAAABKlbEIAATuwWvtTyeyv0mOklLnlQVvaac"
  cloud_id  = "b1gm7ni2v808puh04hm5"
  folder_id = "b1gr2ctfcm32jom2pged"
  zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "bui" {
  name = "bui"

    resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vgqmrilk8dchj1ccf"
      size = "13"
    }
  }

  network_interface {
        subnet_id = yandex_vpc_subnet.subnet-2.id
        nat       = true
  }
  metadata = {
  ssh-keys = "~/.ssh/ilya.pub"
    user-data = "~/.ssh/meta.txt"
  }
}

resource "yandex_vpc_subnet" "subnet-2" {
  name       = "subnet2"
  zone       = "ru-central1-b"
  network_id = "enpelpnqn9o40oe89gnl"
  v4_cidr_blocks = ["192.168.16.0/24"]
}
output "internal_ip_address_bui" {
  value = yandex_compute_instance.bui.network_interface.0.ip_address
}
output "external_ip_address_bui" {
  value = yandex_compute_instance.bui.network_interface.0.nat_ip_address
}