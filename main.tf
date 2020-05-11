resource "azurerm_recovery_services_vault" "vault" {
  name                = "${var.name}-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vault_sku

  soft_delete_enabled = var.soft_delete_enabled

  tags = var.tags
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = "${var.name}-backup-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  timezone = var.timezone

  backup {
    frequency = var.backup_policy.frequency
    time      = var.backup_policy.time
  }

  dynamic "retention_daily" {
    for_each = var.backup_policy == null ? {} : map("key", var.retention_daily_policy)
    content {
      count = retention_daily.value.count
    }
  }

  dynamic "retention_weekly" {
    for_each = var.retention_weekly_policy == null ? {} : map("key", var.retention_weekly_policy)
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.retention_monthly_policy == null ? {} : map("key", var.retention_monthly_policy)
    content {
      count    = retention_monthly.value.count
      weekdays = retention_monthly.value.weekdays
      weeks    = retention_monthly.value.weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.retention_yearly_policy == null ? {} : map("key", var.retention_yearly_policy)
    content {
      count    = retention_yearly.value.count
      weekdays = retention_yearly.value.weekdays
      weeks    = retention_yearly.value.weeks
      months   = retention_yearly.value.months
    }
  }

  tags = var.tags
}

resource "azurerm_backup_protected_vm" "protected_vm" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy.id
  source_vm_id        = var.vm_id

  tags = var.tags
}
