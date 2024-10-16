targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Platform Management'
metadata description = 'Platform management resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('The tags for all platform management resources.')
param tags object

@description('Retention days for platform logging.')
param platformLoggingRetentionDays int

@description('The SKU for the platform Log Analytics workspace.')
@allowed([
  'PerNode'
  'PerGB2018'
  'Standalone'
  'Premium'
  'Standard'
])
param platformLogAnalyticsSku string

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
    tags: tags
    platformLoggingRetentionDays: platformLoggingRetentionDays
    platformLogAnalyticsSku: platformLogAnalyticsSku
  }
}
