# OathBringer server setup

The playbook provisions this account model:

| Account | Purpose | Sudo | Remote login | Runs agents |
| --- | --- | ---: | --- | ---: |
| `root` | Emergency and system ownership | - | Disabled | No |
| `admin` | OS updates, Ansible, and recovery | Yes | SSH | No |
| `dev` | Mosh, Moshi, Herdr, GitHub, and coding | No | SSH and Mosh | Yes |

Run setup from an existing SSH account with a populated `authorized_keys` file. Its keys are copied to both `admin` and `dev` before root SSH is disabled.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/blntrsz/oathbringer/refs/heads/main/setup.sh)"
```

If already logged in as root, omit `sudo`. After setup, reconnect as `admin` for system administration or `dev` for development:

```bash
ssh admin@server
mosh dev@server
```

`admin` has passwordless sudo because password authentication is disabled. `dev` is not a sudoer. Mosh also requires UDP ports `60000:61000` to be allowed by the host or cloud firewall.

Docker Engine, Buildx, and Docker Compose are installed from Docker's official Ubuntu repository. The `dev` account belongs to the `docker` group, so reconnect after provisioning before running `docker` or `docker compose` without sudo. GitHub CLI is installed system-wide from GitHub's official APT repository.

PM2 runs `opencode serve --hostname 0.0.0.0` as `dev` from `/home/dev`. Its process list is restored at boot by the `pm2-dev.service` systemd unit. Provisioning securely prompts for and confirms `OPENCODE_SERVER_PASSWORD`; rerunning the playbook updates the running server with the newly supplied password.
