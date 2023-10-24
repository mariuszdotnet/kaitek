@description('Storage Account type')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
])
param storage_account_type string = 'Standard_LRS'
param storage_account_name string
param location string = resourceGroup().location

resource storage_account 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storage_account_name
  location: location
  sku: {
    name: storage_account_type
  }
  kind: 'Storage'
}

output storage_account_name string = storage_account.name
output storage_account_id string = storage_account.id
