variable "proxmox_api" {
  type = string
  default = "https://10.0.10.100:8006/api2/json"
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_pass" {
  type = string
}

variable "lxc_data" {
  type = map(object({
    node = string
    telmate = string
    password = string
    rootf_storage = string
    rootf_size = string
    network_name = string
    network_bridge = string
    network_gw = string
    loadbalance_ip = string
  }))

  default = {
    "lxc" = {
      node = "prox00"
      telmate = "local:vztmpl/ubuntu22.04.tar.zst"
      password = "password"
      rootf_storage = "local-lvm"
      rootf_size = "8G"
      network_name = "eth0"
      network_bridge = "vmbr0"
      network_gw = "10.0.10.1"
      loadbalance_ip = "10.0.10.160/24"
    }
  }
}

variable "dinamic_lxc_data" {
  type = map(object({
    vmid = number
    hostname = string
    ip = string
  }))

  default = {
    "nginx_node1" = {
      vmid = 150
      hostname = "node1"
      ip = "10.0.10.150/24"
    }

    "nginx_node2" = {
      vmid = 151
      hostname = "node2"
      ip = "10.0.10.151/24"
    }

    "nginx_node3" = {
      vmid = 152
      hostname = "node3"
      ip = "10.0.10.152/24"
    }
  }
}
