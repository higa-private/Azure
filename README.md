# Azure
sandbox
## AzureでTerraform実行に必要な初期設定

１．AZコマンドインストール
２．az login コマンドを実行し、ブラウザで認証する
３．以下のコマンドでサブスクリプションIDを取得
    az account show --query id -o tsv
４．以下のコマンドでServicePrincipalを作成
    az add sp create-for-rbac --name "SP名" --role "Contributor" --scopes "/subscriptions/サブスクリプションID"

    ※以下は作成したときだけの確認できるので控えておく（紛失するとResetが必要）
      "appId": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      "displayName": "SP名",
      "password": "XXXXXXXXXXXXXXXXXXXXXX
      "tenant": "XXXXX-XXXX-XXXX-XXXX-XXXXXXXXX"
５．Provider.tfで使用する値を変数に入れる。
６．ServicePrincipalに権限を付与する
　　az role assignment create \
    --assignee "099877dd-a3a7-4e34-96eb-38487acd7541" \
    --role "User Access Administrator" \
    --scope "/subscriptions/e75d5866-17d3-41a1-8868-12059d82f357"


## VM作成に必要な初期設定
１．開発端末で、VMへの接続に使用する鍵を作成する（VMへのはPassWordではなく鍵認証とする）

## Terraformをバックエンド管理にするため、ローカル上のtfstateファイルをBlobにUploadする
$ az storage blob upload \
      --account-name develop01 \
      --container-name tfstate20250911 \
      --name terraform.tfstate \
      --file ./terraform.tfstate   

## キーコンテナの値修正（Terraformで作成後に実行）
    az keyvault secret set --vault-name <KeyVault名> --name <シークレット名> --value "<新しい値>"

# HostOSに必要な設定
１．AzureCLIをインストール
    参考サイト：https://learn.microsoft.com/ja-jp/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=dnf

# WorkFlow
## jobs
