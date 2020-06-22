#!/bin/bash

# Update and Install tuya-convert
sudo apt update && sudo apt upgrade -y
git clone https://github.com/ct-Open-Source/tuya-convert
cd tuya-convert
./install_prereq.sh

# Flash Tasmota
./start_flash.sh
