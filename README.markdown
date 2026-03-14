# Ruby Compile Farm

Creates a Hetzner ARM VM, downloads a Ruby compiler, compiles it for `arm-linux-gnueabihf` (for a 32 bit Raspberry Pi, e.g. Raspberry Pi 3 or Zero 2W),zips it up and downlads it to the controlling machine.

# Installation

We are using Terraform to

1. Create a new VM, and
1. Install Tailscale

## Prerequsites

* The environment variable `HCLOUD_TOKEN` must be a valid [Hetzner Cloud Token](https://docs.hetzner.cloud/#authentication).
* The environment variable `TAILSCALE_API_KEY` must have a valid [Tailscale API key](https://login.tailscale.com/admin/settings/keys)
* The server name is set in `variables.tf`, and can be overwritten on the command line as `-var server_name=foobar`.

## Up

```command
scripts/create
```

The playbook will download the compiled Ruby as `ruby-4.0.1-armhf-debian13.tar.gz` to the controlling machine.

When copied to a Raspberry Pi, it can be unpacked and installed and used using the following commands:

```command
$ sudo tar -xzf ruby-4.0.1-armhf-debian13.tar.gz -C /
$ PATH=/opt/ruby-4.0.1/bin:$PATH ruby --version
```

## Down

```command
scripts/destroy
```

# Troubleshooting

1. Does the server exist in the Hetzner Cloud?

    ```command
    $ hcloud server list
    ```

1. Can you ssh into it using `hcloud`?

    ```command
    $ hcloud server ssh ruby-compiler
    ```

1. Did the cloud-init script succeed?

    ```command
    $ less /var/log/cloud-init.log
    $ less /var/log/cloud-init-output.log
    ```

1. Can you `tailscale ssh ruby-compiler` into the machine?

   Output appears in the cloud-init logfiles as mentioned above.

1. Did the Ansible playbook succeed?

# References

* [Build A Portable Lab In The Cloud Using Tailscale, Terraform and DigitalOcean](https://rossedman.io/blog/computers/scale-homelab-with-tailscale/)
* [Hetzner Cloud Terraform Provider](https://community.hetzner.com/tutorials/howto-hcloud-terraform)
* [Install Tailscale with cloud-init](https://tailscale.com/kb/1293/cloud-init)
