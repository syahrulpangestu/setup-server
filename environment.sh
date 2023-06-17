#!/bin/bash

set -e  

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

exit_with_error() {
  echo -e "${RED}Error: $1${NC}"
  exit 1
}

check_dependency() {
  if ! command -v "$1" &> /dev/null; then
    return 1
  fi
  return 0
}

timedatectl set-timezone Asia/Jakarta || exit_with_error "Failed to set timezone"

apt update || exit_with_error "Failed to update packages"
apt upgrade -y || exit_with_error "Failed to upgrade packages"

if ! check_dependency "git"; then
  apt install -y git || exit_with_error "Failed to install Git"
fi

if ! check_dependency "curl"; then
  apt install -y curl || exit_with_error "Failed to install Curl"
fi

if ! check_dependency "zip"; then
  apt install -y zip || exit_with_error "Failed to install ZIP"
fi

if ! check_dependency "python3"; then
  apt install -y python3 || exit_with_error "Failed to install Python 3"
fi

if ! check_dependency "pip3"; then
  apt install -y python3-pip || exit_with_error "Failed to install Python 3-pip"
fi

if ! check_dependency "docker"; then
  curl -fsSL https://get.docker.com -o get-docker.sh || exit_with_error "Failed to download Docker installation script"
  sh get-docker.sh || exit_with_error "Failed to install Docker"
  rm get-docker.sh
fi

echo -e "${GREEN}Server setup completed successfully!${NC}"