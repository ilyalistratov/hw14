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

resource "yandex_compute_instance" "build" {
  name = "build1"

    resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "epd2a7hmo6pck70ldh3b"
    }
  }

  network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
  }
}

resource "yandex_vpc_subnet" "subnet-1" {
  name       = "subnet1"
  zone       = "ru-central1-b"
  network_id = "e2lisbffs41g0kebmld5"
  v4_cidr_blocks = ["192.168.10.0/16"]
}
output "internal_ip_address_build" {
  value = yandex_compute_instance.build.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.build.network_interface.0.nat_ip_address
}