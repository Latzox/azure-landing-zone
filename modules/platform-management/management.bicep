targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Platform Management'
metadata description = 'Platform management resources for Azure Landing Zone'

param location string = 'switzerlandnorth'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-platformlogging-prod-001'
  location: location
  tags: {
    workload: 'azure-landing-zone'
    topic: 'platform-management'
    environment: 'prod'
  }
}

module logging 'logging/logging.bicep' = {
  name: 'deploy-platform-logging'
  scope: resourceGroup
}
