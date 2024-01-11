targetScope = 'resourceGroup'

param location string = resourceGroup().location
param app_service_plan_name string
@description('True if the plan is for Linux, false if it is for Windows.')
param app_plan_os bool

resource app_service_plan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: app_service_plan_name
  location: location
  sku: {
    name: 'P0v3'
  }
  properties: {
    reserved: app_plan_os
  }
}

output app_service_plan_id string = app_service_plan.id
