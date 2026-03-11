terraform {
  required_providers {
    hcloud = { source = "hetznercloud/hcloud" }
    tailscale = { source = "tailscale/tailscale" }
  }
}

variable "server_name" {
  description = "Server name"
  type        = string
  default = "ruby-compiler"
}
