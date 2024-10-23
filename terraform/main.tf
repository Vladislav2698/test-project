terraform {
    required_providers {
      proxmox = {
        source = "localhost/telmate/proxmox"
        version = "3.0.1-rc4"
      }
    }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api
  pm_user = var.proxmox_user
  pm_password = var.proxmox_pass
  pm_tls_insecure = true
}

resource "proxmox_lxc" "nodes" {
  for_each = var.dinamic_lxc_data

  target_node = var.lxc_data.lxc.node
  hostname = each.value.hostname
  vmid = each.value.vmid
  ostemplate = var.lxc_data.lxc.telmate
  password = var.lxc_data.lxc.password
  cores = 1
  memory = 1024
  swap = 512
  unprivileged = true
  
  rootfs {
    storage = var.lxc_data.lxc.rootf_storage
    size = var.lxc_data.lxc.rootf_size
  }

  network {
    name = var.lxc_data.lxc.network_name
    bridge = var.lxc_data.lxc.network_bridge
    ip = each.value.ip
    gw = var.lxc_data.lxc.network_gw
  }
}

resource "proxmox_lxc" "loadbalance" {
  target_node = var.lxc_data.lxc.node
  hostname = "loadbalance"
  vmid = 160
  ostemplate = var.lxc_data.lxc.telmate
  password = var.lxc_data.lxc.password
  cores = 1
  memory = 1024
  swap = 512
  unprivileged = true

  rootfs {
    storage = var.lxc_data.lxc.rootf_storage
    size = var.lxc_data.lxc.rootf_size
  }
  
  network {
    name = var.lxc_data.lxc.network_name
    bridge = var.lxc_data.lxc.network_bridge
    ip = var.lxc_data.lxc.loadbalance_ip
    gw = var.lxc_data.lxc.network_gw
  }
}
