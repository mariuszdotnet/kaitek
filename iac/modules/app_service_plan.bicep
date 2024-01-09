targetScope = 'resourceGroup'

param location string = resourceGroup().location
param app_service_plan_name string

resource app_service_plan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: app_service_plan_name
  location: location
  sku: {
    name: 'P0v3'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output app_service_plan_id string = app_service_plan.id
