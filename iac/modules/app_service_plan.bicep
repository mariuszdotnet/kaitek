targetScope = 'resourceGroup'

param location string = resourceGroup().location

resource app_service_plan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'app_service_plan'
  location: location
  sku: {
    name: 'P0V3'
    tier: 'PremiumV3'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output app_service_plan_id string = app_service_plan.id
