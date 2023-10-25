// Reference from here - https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.web/function-app-linux-consumption/main.bicep

param function_app_name string
param location string = resourceGroup().location
param function_kind string
param hosting_plan_id string
param storage_account_name string

@description('Required for Linux app to represent runtime stack in the format of \'runtime|runtimeVersion\'. For example: \'python|3.9\'')
param linux_fx_version string

@description('The language worker runtime to load in the function app.')
@allowed([
  'dotnet'
  'node'
  'python'
  'java'
])
param function_worker_runtime string

resource storage_account 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storage_account_name
}

var storage_account_key = storage_account.listKeys().keys[0].value

resource functionApp 'Microsoft.Web/sites@2022-09-01' = {
  name: function_app_name
  location: location
  kind: function_kind
  properties: {
    reserved: true
    serverFarmId: hosting_plan_id
    siteConfig: {
      linuxFxVersion: linux_fx_version
      alwaysOn: true
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storage_account_name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storage_account_key}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: function_worker_runtime
        }
      ]
    }
  }
}
