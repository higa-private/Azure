AlmaLinux9.x(OS)
・dockerコマンド(sudo dnf install -y podman-docker)が必要
・dockerはpodmanではなく、docker-ceをする（推奨らしい）

sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
docker version
