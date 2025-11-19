#!/bin/bash
# VPSMakers.com – MikroTik CHR Installer for Ubuntu 20/22/24
# Author: VPSMakers

echo "=== VPSMakers | Installing dependencies for MikroTik CHR ==="
sudo apt update
sudo apt install -y qemu-kvm qemu-utils libvirt-daemon-system libvirt-clients bridge-utils wget unzip

echo "=== Creating network bridge br0 ==="
BRIDGE_CONFIG="/etc/netplan/99-br0.yaml"

if [ ! -f "$BRIDGE_CONFIG" ]; then
cat <<EOF | sudo tee $BRIDGE_CONFIG
network:
  version: 2
  renderer: networkd
  bridges:
    br0:
      interfaces: []
      dhcp4: yes
EOF

echo "Applying Netplan..."
sudo netplan apply
fi

echo "=== Downloading MikroTik CHR ==="
wget -O chr.img.zip https://download.mikrotik.com/routeros/7.17.2/chr-7.17.2.img.zip

echo "Extracting CHR..."
unzip chr.img.zip
mv *.img chr.img

echo "=== Creating QCOW2 disk ==="
qemu-img convert -f raw -O qcow2 chr.img chr.qcow2

echo "=== Creating VM directory ==="
sudo mkdir -p /var/lib/mikrotik
sudo mv chr.qcow2 /var/lib/mikrotik/chr.qcow2

echo "=== Creating systemd service ==="

cat <<EOF | sudo tee /etc/systemd/system/mikrotik.service
[Unit]
Description=MikroTik CHR Virtual Machine
After=network.target

[Service]
ExecStart=/usr/bin/qemu-system-x86_64 \\
  -m 1024 \\
  -smp 2 \\
  -drive file=/var/lib/mikrotik/chr.qcow2,if=none,id=disk \\
  -device virtio-blk-pci,drive=disk \\
  -nic bridge,br=br0,model=virtio \\
  -nographic

Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "=== Enabling MikroTik CHR service ==="
sudo systemctl daemon-reload
sudo systemctl enable mikrotik
sudo systemctl start mikrotik

echo "=== Installation Complete ==="
echo "MikroTik CHR is now running on your Ubuntu server!"
echo "Visit VPSMakers.com for more tools."
