📌 MikroTik CHR Quick Deployment Script for Ubuntu

By VPSMakers.com

This repository provides a simple and reliable script that allows you to deploy MikroTik CHR on Ubuntu using QEMU, without needing to manually configure networking or virtualization components.

The script is designed for Ubuntu servers and helps users quickly boot MikroTik CHR as a virtual machine, making it ideal for tunneling, routing, VPN, or lab environments.

🚀 Features

Automated setup of QEMU/KVM

Downloads the latest MikroTik CHR image

Creates and boots a persistent VM

Auto-generates a network bridge

Works on Ubuntu 20.04 / 22.04 / 24.04

Clean, safe, and customizable

📦 Requirements

Ubuntu Server 20.04 / 22.04 / 24.04

Root or sudo access

Minimum 2 GB RAM

Minimum 20 GB disk

CPU virtualization enabled (VT-x / AMD-V)

🔧 Installation

Run the script with a single command:
curl -sSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO/main/vpsmakers-mikrotik.sh -o vpsmakers-mikrotik.sh && chmod +x vpsmakers-mikrotik.sh && sudo ./vpsmakers-mikrotik.sh
Replace YOUR_GITHUB_USERNAME and YOUR_REPO after uploading your script.
