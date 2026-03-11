#cloud-config
---
package_update: true
package_upgrade: true
ssh_pwauth: false
ssh_keys:
  ecdsa_private: |
    ${indent(4, ssh_host_key.private_key_openssh)}
  ecdsa_public: |
    ${indent(4, ssh_host_key.public_key_openssh)}
runcmd:
  - [ sh, -c, 'curl -fsSL https://tailscale.com/install.sh | sh']
  - [ tailscale, up, -authkey, "${tailscale_auth_key}", --ssh, --accept-routes, --hostname, "${server_name}" ]
ansible:
  package_name: ansible
  install_method: distro
  pull:
    url: https://github.com/suhlig/foundation
    playbook_name: roles/main/example/local.yml
  galaxy:
    actions:
      - ["ansible-galaxy", "collection", "install", "suhlig.foundation"]
