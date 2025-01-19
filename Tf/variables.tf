variable "subscription_id" {

  

  type = string

  description = "value"

}

 

# variable "key_vault_name" {

#   type        = string

#   description = "The name of the Key Vault. Changing this forces a new resource to be created."

# }

variable "location" {

  type        = string

  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."

}

variable "resource_group_name" {

  type        = string

  description = "Name of resource group name"

}

variable "tenant_id" {

  type        = string

  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"

}

# variable "sku_name" {

#   type        = string

#   description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."

# }

variable "admin_password" {
  type = string 
  
}