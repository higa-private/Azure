AlmaLinux9.x(OS)
・dockerコマンド(sudo dnf install -y podman-docker)が必要
・dockerはpodmanではなく、docker-ceをする（推奨らしい）

  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  docker version
  ※dockerバージョンコマンドでエラーになる場合は、Dockerににグループ所属させる

・azインストールが必要

コンテナ
  docker.io/library/node:iron-trixie-slim は ca-certificates が含まれていないのでhttpsでの接続ができない。
  そのため、まずca-certificatesをインストーしてからsedでhttpsに置換する。
　※ACRにイメーか格納するときに、ca-certificatesをインストールしておく

  apt-get update
  apt-get install -y ca-certificates

キーコンテナ
Terrafrom実行用サービス プリンシパルにはIAMロール権限追加ができないので手動で以下を設定する
・共同作成者
・キー コンテナー シークレット責任者

秘密情報するコマンド
az keyvault secret show --vault-name terraform20250909 --name subscription-id --query "value" -o tsv

