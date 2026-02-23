#!/bin/bash

set -e

folders=(
#  "01-vpc"
#  "02-sg"
#  "03-bastion"
#  "04-db"
#  "05-openvpn"
#  "06-app_alb"
#  "07-backend"
  "07.1-acm"
  "08-web-alb"
#  "09-frontend"
)

for folder in "${folders[@]}"; do
  echo "================================="
  echo "Deploying $folder"
  echo "================================="

  cd $folder
  terraform init
  terraform apply -auto-approve -lock=false
  cd ..
done

echo "All modules deployed successfully!"
