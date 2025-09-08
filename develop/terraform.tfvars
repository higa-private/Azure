#provider_credentials = {
#  subscription_id  = "xxxx"     #subscription ID
#  tenant_id        = "xxxx"     #az ad sp create-for-rbacaz ad sp create-for-rbac --name sp_for_terraform --role Contributor --scopes "/subscriptions/e75d5866-17d3-41a1-8868-12059d82f357" --name sp_for_terraform --role Contributor --scopes "/subscription/<subscriptionIDを入れる>で出たAPPIDを入れる
#  sp_client_id     = "xxxx"     #アプリの登録のID
#  sp_client_secret = "xxxx"     #証明書とシークレットの値
#}

resource_group_name = "rg-develop"
vnet_address_space  = ["10.0.0.0/23"]

develop_subnet_name             = ["vm-subnet", "bastion-work", "endpoint-subnet", "firewall-subnet"]
develop_subnet_address_prefixes = ["10.0.0.0/28", "10.0.1.0/28", "10.0.1.16/28", "10.0.0.16/28"]

# vm.tf
public_ip_name = "runner-pub-ip"
nsg_name       = "develop-nsg"
nsg_rules = [
  {
    name                       = "RPD"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    destination_address_prefix = "*"
  },
  {
    name                       = "SSH"
    priority                   = 1001
    access                     = "Allow"
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowAll"
    priority                   = 1000
    access                     = "Allow"
    direction                  = "Outbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
]

nic_name           = "develop-nic"
#private_ip_address = "10.0.X.X" # secret.tfvarsに記載

#VM用ストレージアカウント
storage_account_name = "develop01"

#vm設定
vm_name           = "runner-vm"
admin_username    = "higa"
vm_size           = "Standard_B1s"
os_disk_size_gb   = 30
data_disk_size_gb = 10
