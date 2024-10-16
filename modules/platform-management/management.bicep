targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Platform Management'
metadata description = 'Platform management resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('The tags for all platform management resources.')
param tags object

@description('Naming convention for all resources.')
param namingConvention object

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

@description('Resource group for platform logging.')
resource rgPlatformLogging 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: namingConvention.resourceGroupPlatformLogging
  location: location
  tags: tags
}

@description('Deploy platform logging')
module logging 'logging/logging.bicep' = {
  name: 'deploy-platform-logging'
  scope: rgPlatformLogging
  params: {
    location: location
    tags: tags
    namingConvention: namingConvention
    platformLoggingRetentionDays: platformLoggingRetentionDays
    platformLogAnalyticsSku: platformLogAnalyticsSku
  }
}
