provider "hcloud" { }

provider "tailscale" {
  tailnet = "uhlig-it.org.github"
}

resource "tls_private_key" "ssh_host_key" {
  algorithm = "ED25519"
}

resource "tailscale_tailnet_key" "tailscale_auth_key" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 3600
}

data "hcloud_ssh_key" "ssh_user_key" {
  name = "suhlig@lima"
}

resource "hcloud_server" "hcloud-server" {
  name = var.server_name
  server_type = "cax41"     # hcloud server-type list
  image       = "debian-13" # hcloud image list --type system
  location    = "fsn1"      # hcloud datacenter list
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  ssh_keys = [ "suhlig@lima" ] # already uploaded to Hetzner
  user_data = templatefile("${path.module}/userdata.tpl", {
    tailscale_auth_key = tailscale_tailnet_key.tailscale_auth_key.key
    ssh_host_key = tls_private_key.ssh_host_key
    server_name = var.server_name
  })
}

output "ssh_host_key_fingerprint" {
  value = tls_private_key.ssh_host_key.public_key_fingerprint_sha256
}

output "ssh_user_key_fingerprint" {
  value = data.hcloud_ssh_key.ssh_user_key.fingerprint
}

output "ssh_host_key_public" {
  value = tls_private_key.ssh_host_key.public_key_openssh
}
