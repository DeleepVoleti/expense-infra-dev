#!/bin/bash

set -e

folders=(
  "09-frontend"
  "08-web-alb"
  "07.1-acm"
  #"07-backend"
  "06-app_alb"
  #"05-openvpn"
  "04-db"
  #"03-bastion"
  "02-sg"
  "01-vpc"
)

for folder in "${folders[@]}"; do
  echo "================================="
  echo "Destroying $folder"
  echo "================================="

  cd $folder
  terraform init
  terraform destroy -auto-approve -lock=false
  cd ..
done

echo "All modules destroyed successfully!"
