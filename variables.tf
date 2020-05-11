variable name {
  description = "The name of the resources to create."
  type        = string
}

variable location {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable resource_group_name {
  description = "The name of the resource group in which to create the Recovery Services Protected VM."
  type        = string
}

variable vault_sku {
  description = "Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default     = "Standard"
}

variable soft_delete_enabled {
  description = "Is soft delete enable for this Vault?"
  type        = bool
  default     = true
}

variable vm_id {
  description = "Specifies the ID of the VM to backup."
  type        = string
}

variable timezone {
  description = "Specifies the timezone."
  type        = string
  default     = "UTC"
}

variable backup_policy {
  description = "Configures the Policy backup frequency, times & days as documented in the backup block below."
  type = object({
    frequency = string
    time      = string
  })
  default = {
    frequency = "Daily"
    time      = "23:00"
  }
}

variable retention_daily_policy {
  description = "Configures the policy daily retention. Required when backup frequency is Daily. Must be between 7 and 9999."
  type = object({
    count = number
  })
  default = null
}

variable retention_weekly_policy {
  description = "Configures the policy weekly retention. Required when backup frequency is Weekly."
  type = object({
    count    = number
    weekdays = list(string)
  })
  default = null
}

variable retention_monthly_policy {
  description = "Configures the policy monthly retention."
  type = object({
    count    = number
    weekdays = list(string)
    weeks    = list(string)
  })
  default = null
}

variable retention_yearly_policy {
  description = "Configures the policy yearly retention"
  type = object({
    count    = number
    weekdays = list(string)
    weeks    = list(string)
    months   = list(string)
  })
  default = null
}

variable tags {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
