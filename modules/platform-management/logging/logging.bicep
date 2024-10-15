targetScope = 'resourceGroup'

metadata name = 'Azure Landing Zone - Logging'
metadata description = 'Logging resources for Azure Landing Zone'

param location string = resourceGroup().location

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'law-platform-prod-001'
  location: location
  tags: {
    workload: 'azure-landing-zone'
    topic: 'platform-management'
    environment: 'prod'
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
  }
}
