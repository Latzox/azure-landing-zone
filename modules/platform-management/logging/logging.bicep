targetScope = 'resourceGroup'

metadata name = 'Azure Landing Zone - Logging'
metadata description = 'Logging resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('Tags for all resources.')
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

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'law-platform-prod-001'
  location: location
  tags: tags
  properties: {
    sku: {
      name: platformLogAnalyticsSku
    }
    retentionInDays: platformLoggingRetentionDays
  }
}
