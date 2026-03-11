#cloud-config
---
package_update: true
package_upgrade: true
ssh_pwauth: false
ssh_keys:
  ed25519_private: |
    ${indent(4, ssh_host_key.private_key_pem)}
  ed25519_public: |
    ${indent(4, ssh_host_key.public_key_openssh)}
runcmd:
  - [ sh, -c, 'curl -fsSL https://tailscale.com/install.sh | sh']
  - [ tailscale, up, -authkey, "${tailscale_auth_key}", --ssh, --accept-routes, --hostname, "${server_name}" ]
