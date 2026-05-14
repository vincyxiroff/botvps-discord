# botvps-discord

Discord bot to provision/manage LXC VPS containers.

## Quick setup (Ubuntu/Debian host)

```bash
chmod +x install.sh
sudo ./install.sh
source .venv/bin/activate
python3 main.py
```

## What `install.sh` now does

- Installs system dependencies (`lxd`, `wondershaper`, `python3`, `python3-pip`, etc.)
- Runs non-interactive `lxd init --auto` if LXD is not initialized yet
- Creates a local Python virtual environment (`.venv`)
- Installs Python dependencies used by the bot (`discord.py`, `psutil`)
- Verifies `lxc` CLI availability

## SSH port range

The bot can assign SSH proxy ports using a configurable range in `main.py`:

- `ssh_port_start = 22000`
- `ssh_port_end = 22999`

User command:

- `-sshport` → auto-assigns (or reuses) a free SSH proxy port for the user container

`-infovps` also includes the current SSH port mapping.

## Docker version

https://github.com/vincyxiroff/botvps-dockerds
