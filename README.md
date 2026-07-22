# OathBringer server setup

The playbook provisions this account model:

| Account | Purpose | Sudo | Remote login | Runs agents |
| --- | --- | ---: | --- | ---: |
| `root` | Emergency and system ownership | - | Disabled | No |
| `admin` | OS updates, Ansible, and recovery | Yes | SSH | No |
| `dev` | Mosh, Herdr, GitHub, and coding | No | SSH and Mosh | Yes |

Run setup from an existing SSH account with a populated `authorized_keys` file. Its keys are copied to both `admin` and `dev` before root SSH is disabled.

```bash
curl -fsSL https://raw.githubusercontent.com/blntrsz/oathbringer/refs/heads/main/setup.sh | sudo bash
```

If already logged in as root, omit `sudo`. After setup, reconnect as `admin` for system administration or `dev` for development:

```bash
ssh admin@server
mosh dev@server
```

`admin` has passwordless sudo because password authentication is disabled. `dev` is not a sudoer. Mosh also requires UDP ports `60000:61000` to be allowed by the host or cloud firewall.
