targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Platform Management'
metadata description = 'Platform management resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('The tags for all platform management resources.')
param tags object

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-platformlogging-prod-001'
  location: location
  tags: tags
}

module logging 'logging/logging.bicep' = {
  name: 'deploy-platform-logging'
  scope: resourceGroup
  params: {
    location: location
  }
}
