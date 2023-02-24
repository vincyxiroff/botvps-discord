echo "Starting Container Creation..."
sleep 2
echo -n "Name the container: "
read -r container_name
echo -n "OS: "
read -r os
echo "Creating container"
lxc launch images:"$os" "$container_name"
lxc config set "$container_name" limits.cpu.allowance 10%
lxc config set "$container_name" limits.memory 256MB
lxc config device override "$container_name" root size=750MB
lxc exec "$container_name" -- apt update
lxc exec "$container_name" -- apt install wget openssh-server -y
lxc exec "$container_name" -- rm -rf /etc/ssh/sshd_config
lxc exec "$container_name" -- wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/dxomg/sshd_config/main/sshd_config
lxc exec "$container_name" -- systemctl restart ssh
lxc exec "$container_name" -- rm -rf /etc/hostname
lxc exec "$container_name" -- "echo 'UnknownVPS' >> /etc/hostname"
lxc exec "$container_name" -- passwd
echo -n "SSH Port: "
read -r port
lxc config device add "$container_name" ssh proxy listen=tcp:0.0.0.0:"$port" connect=tcp:127.0.0.1:22
lxc stop "$container_name"
lxc start "$container_name"
echo "Container Creation Success! Name: "$container_name""
