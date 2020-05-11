output recovery_services_vault_id {
    value = azurerm_recovery_services_vault.vault.id
}

output backup_policy_vm_id {
    value = azurerm_backup_policy_vm.backup_policy.id
}

output backup_protected_vm_id {
    value = azurerm_backup_protected_vm.protected_vm.id
}
