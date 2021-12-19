terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
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
  platform_id = "standard-v1"
  zone = "ru-central1-b"
  }

  resources {
    cores  = 2
    memory = 4
  }
  
  boot_disk {
    initialize_params {
      image_id = "image_id"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.foo.id}"
  }

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone       = "ru-central1-b"
  network_id = "${yandex_vpc_network.foo.id}"
}

