# Terraform Azure VM Backup Policy

Add a backup policy to an existing Virtual Machine.
Tested with Azure Provider 2.9.0.

This module creates the following resources:
- azurerm_recovery_services_vault
- azurerm_backup_policy_vm
- azurerm_backup_protected_vm

## How to use it

```hcl
module "vm-backup-policy" {
  source  = "github.com/scalair/terraform-azure-vm-backup-policy"
  version = "v1.0.0"
  
  name = "policy-name"

  resource_group_name = "rg-name"
  location            = "francecentral"

  vm_id               = "vm-id"
  timezone            = "Romance Standard Time"
  soft_delete_enabled = false

  backup_policy = {
    frequency = "Daily"
    time      = "01:00"
  }

  retention_daily_policy = {
    count = 7
  }
  
  tags = {
      terraform   = true
      environment = "dev"
  }
}
```