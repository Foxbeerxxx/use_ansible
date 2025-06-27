locals {
  ssh_key   = file(pathexpand("~/.ssh/id_ed25519.pub"))
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "default" {
  name = "default-network"
}

resource "yandex_vpc_subnet" "default" {
  name           = "default-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "clickhouse" {
  name        = "clickhouse-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = file("cloud-init/clickhouse.yaml")
  }
}

resource "yandex_compute_instance" "vector" {
  name        = "vector-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = templatefile("cloud-init/vector.yaml.tmpl", {
      clickhouse_ip = yandex_compute_instance.clickhouse.network_interface[0].ip_address
    })
  }
}

resource "yandex_compute_instance" "lighthouse" {
  name        = "lighthouse-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = templatefile("cloud-init/lighthouse.yaml.tmpl", {
      clickhouse_ip = yandex_compute_instance.clickhouse.network_interface[0].ip_address
    })
  }
}
