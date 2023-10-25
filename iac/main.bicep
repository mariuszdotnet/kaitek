// Deployment Scope
targetScope='subscription'

// Parameters
param location string = deployment().location

// Variables
var suffix = 'kaitek'
var app_service_rg_name = 'app_service_rg'
var storage_account_name  = '${uniqueString(subscription().subscriptionId)}storage'
var function_app_name = 'client-function-${suffix}'

// Resources Groups

resource app_service_rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: app_service_rg_name
  location: location
}

// Resources
module app_service_plan './modules/app_service_plan.bicep' = {
  name: 'app_service_plan'
  scope: resourceGroup(app_service_rg.name)
  params: {
    location: location
  }
}

module function_storage_account './modules/storage_account.bicep' = {
  name: storage_account_name
  scope: resourceGroup(app_service_rg.name)
  params: {
    location: location
    storage_account_name: storage_account_name
  }
}

module azure_function './modules/azure_function.bicep' = {
  name: 'client_azure_function'
  scope: resourceGroup(app_service_rg.name)
  params: {
    location: location
    function_app_name: function_app_name
    function_kind: 'functionapp,linux'
    function_worker_runtime: 'python'
    linux_fx_version: 'Python|3.11'
    hosting_plan_id: app_service_plan.outputs.app_service_plan_id
    storage_account_name: function_storage_account.outputs.storage_account_name
  }
}

