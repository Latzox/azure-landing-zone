targetScope = 'resourceGroup'

metadata name = 'Azure Landing Zone - Logging'
metadata description = 'Logging resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('Tags for all resources.')
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

@description('Log analytics workspace for platform management.')
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: namingConvention.managementLogAnalyticsWorkspace
  location: location
  tags: tags
  properties: {
    sku: {
      name: platformLogAnalyticsSku
    }
    retentionInDays: platformLoggingRetentionDays
  }
}
