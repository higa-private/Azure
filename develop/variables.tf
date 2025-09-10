variable "provider_credentials" {
  type = object({
    subscription_id  = string
    tenant_id        = string
    sp_client_id     = string
    sp_client_secret = string
  })
}

# リソースグループ名
variable "resource_group_name" {
  type    = string
  default = "develop"
}

variable "location" {
  type    = string
  default = "japaneast"
}

variable "tags_owner" {
  type    = string
  default = "higa"
}

variable "tags_resourcegroup" {
  type    = string
  default = "develop"
}

variable "tags_environment" {
  type    = string
  default = "develop"
}

# Virtual Networkのアドレス空間
variable "vnet_address_space" {
  type    = list(string)
  default = []
}
# Virtual Network名
variable "virtual_network_name" {
  type    = string
  default = "develop-vnet"
}

variable "tags_vnet" {
  type    = string
  default = "develop"
}

# Subnet名
variable "develop_subnet_name" {
  type    = list(string)
  default = []
}
# Subnetのアドレス空間
variable "develop_subnet_address_prefixes" {
  type    = list(string)
  default = []
}

# Network Interface名
variable "nic_name" {
  type    = string
  default = "develop-nic"
}
# Network Security Group名
variable "nsg_name" {
  type    = string
  default = "develop-nsg"
}
# Network Security Groupのルール
variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    access                     = string
    direction                  = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    #source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}
variable "nsg_inbound_ip" {
  type    = string
  default = ""
}
variable "nsg_outbound_ip" {
  type    = string
  default = ""
}
variable "public_ip_name" {
  type    = string
  default = "develop-pub-ip"
}

# Private IPアドレス
variable "private_ip_address" {
  type    = string
  default = ""
}

variable "storage_account_name" {
  type    = string
  default = ""
}

# VM名
variable "vm_name" {
  type    = string
  default = "develop-vm"
}
# VMサイズ
variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

# 管理者ユーザー名
variable "admin_username" {
  type    = string
  default = "azureuser"
}
# 管理者パスワード
variable "admin_password" {
  type    = string
  default = ""
}

# VM用OSディスクの種類
variable "os_disk_type" {
  type    = string
  default = "Standard_LRS"
}
# VM用OSディスクのサイズ(GB)
variable "os_disk_size_gb" {
  type    = number
  default = 30
}
# VM用OSディスクの名前
variable "osdisk_name" {
  type    = string
  default = "develop-osdisk"
}

# VMイメージの発行元
variable "vm_image_publisher" {
  type    = string
  default = ""
}
# VMイメージの提供元
variable "vm_image_offer" {
  type    = string
  default = ""
}
# VMイメージのSKU
variable "vm_image_sku" {
  type    = string
  default = ""
}
# VMイメージのバージョン
variable "vm_image_version" {
  type    = string
  default = ""
}

# VMのカスタムデータ（cloud-init.txtの内容をBase64エンコードして指定）
variable "vm_custom_data" {
  type    = string
  default = ""
}

variable "data_disk_size_gb" {
  type    = number
  default = 10
}

# サービスエンドポイント
variable "develop_service_endpoints" {
  type    = list(string)
  default = []
}
# Key Vault
variable "key_vault_name" {
  type    = string
  default = ""
} 
variable "key_permissions" {
  type    = list(string)
  default = ["Get", "List", "Create", "Update", "Delete", "Recover", "Backup", "Restore", "Import", "GetRotationPolicy", "SetRotationPolicy", "Rotate"]
}
variable "secret_permissions" {
  type    = list(string)
  default = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
} 
variable "develop_secret_name" {
  type    = list(string)
  default = []
} 