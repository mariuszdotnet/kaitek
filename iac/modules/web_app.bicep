
param web_app_name string
param location string = resourceGroup().location
param hosting_plan_id string
@description('Required for Linux app to represent runtime stack in the format of \'runtime|runtimeVersion\'. For example: \'python|3.9\'')
param linux_fx_version string


resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name:  web_app_name
  location: location
  properties: {
    httpsOnly: false
    serverFarmId: hosting_plan_id
    siteConfig: {
      linuxFxVersion: linux_fx_version
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
