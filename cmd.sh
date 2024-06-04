sudo apt update
sudo apt -y upgrade

# Install Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker ${USER}


# Install Node.js
NODE_MAJOR=20
curl -fsSL "https://deb.nodesource.com/setup_$NODE_MAJOR.x" | sudo -E bash -
sudo apt-get install -y nodejs

# Git global config
git config --global user.name "iclab"
git config --global user.email "iclab@kaist.ac.kr"
git config --global init.defaultBranch main

# Install python
python3 -m venv global_env
source global_env/bin/activate
pip3 install pandas numpy scipy scikit-learn torch tensorflow plotly matplotlib

# Install Nvidia-drivers
# Nouveau Removal. Only require if using ubuntu-desktop
# cat > /etc/modprobe.d/blacklist-nouveau.conf << 'EOF'
# blacklist nouveau
# options nouveau modeset=0
# EOF
# sudo update-initramfs -u
sudo ubuntu-drivers install
sudo reboot now
