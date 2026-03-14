terraform {
  required_providers {
    hcloud = { source = "hetznercloud/hcloud" }
    tailscale = { source = "tailscale/tailscale" }
  }
}

variable "os_name" {
  description = "OS name"
  type        = string
}

variable "os_version" {
  description = "OS version"
  type        = string
}

variable "server_name" {
  description = "Server name"
  type        = string
  default = "ruby-compiler"
}
