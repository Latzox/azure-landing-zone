targetScope = 'tenant'

metadata name = 'Azure Landing Zone'
metadata description = 'Automatic setup of an Azure Landing Zone'

@description('Location for all resources.')
param location string = 'switzerlandnorth'

@description('Naming convention for all resources.')
param namingConvention object = {
  resourceGroupPlatformLogging: 'rg-platformlogging-prod-001'
  resourceGroupHubVnet: 'rg-hubvnet-prod-001'
  resourceGroupPrivateDns: 'rg-privatedns-prod-001'
  managementLogAnalyticsWorkspace: 'law-platform-prod-001'
  connectivityHubVNetName: 'vnet-hub-prod-${location}-001'
  connectivityPrivatednsZoneName: 'cloud.latzo.ch'
}

@description('Network security group names for platform connectivity.')
param nsgs array = [
  'nsg-hub-gateway-prod-001'
  'nsg-hub-firewall-prod-001'
  'nsg-hub-bastion-prod-001'
]

@description('The root management group id for the tenant')
param tenantRootGroupId string = '310c844d-a4ce-41f0-88f8-216f95f1cf44'

@description('The management group scope to which the custom role definitions can be assigned.')
param roleDefinitionsAssignableScope string = 'mg-alz'

@description('The subscription ID of the platform connectivity subscription')
param subIdPlatformConnectivity string = 'b1599fde-3d26-4a36-ace3-bc50ae012b5e'

@description('The subscription ID of the platform identity subscription')
param subIdPlatformIdentity string = 'c2678acf-6c55-482b-9021-8d2021597bb9'

@description('The subscription ID of the platform management subscription')
param subIdPlatformManagement string = 'd37e765a-8e22-40c7-b9f7-fb84e9eb90a6'

@description('The subscription ID of the sandbox subscription')
param subIdSandbox string = 'e48f864b-f420-4f5f-b4c0-d4d7e8401732'

@description('Retention days for platform logging.')
param platformLoggingRetentionDays int = 120

@description('The SKU for the platform Log Analytics workspace.')
@allowed([
  'PerNode'
  'PerGB2018'
  'Standalone'
  'Premium'
  'Standard'
])
param platformLogAnalyticsSku string = 'PerGB2018'

@description('Deploy management groups')
module mgmtgroups 'modules/mgmtgroups/mgmtgroups.bicep' = {
  name: 'deploy-mgmtgroups'
  params: {
    tenantRootGroupId: tenantRootGroupId
  }
}

@description('Deploy role definitions')
module roledefinitions 'modules/roledefinitions/roledefinitions.bicep' = {
  name: 'deploy-roledefinitions'
  params: {
    roleDefinitionsAssignableScope: roleDefinitionsAssignableScope
  }
}

@description('Deploy subscription placements')
module subPlacements 'modules/subplacements/subplacements.bicep' = {
  name: 'deploy-subplacements'
  params: {
    subIdPlatformConnectivity: subIdPlatformConnectivity
    subIdPlatformIdentity: subIdPlatformIdentity
    subIdPlatformManagement: subIdPlatformManagement
    subIdSandbox: subIdSandbox
  }
}

@description('Deploy platform management')
module management 'modules/platform-management/management.bicep' = {
  name: 'deploy-platform-management'
  scope: subscription(subIdPlatformManagement)
  params: {
    location: location
    tags: {
      workload: 'azure-landing-zone'
      topic: 'platform-management'
      environment: 'prod'
    }
    platformLoggingRetentionDays: platformLoggingRetentionDays
    platformLogAnalyticsSku: platformLogAnalyticsSku
  }
}

@description('Deploy platform connectivity')
module connectivity 'modules/platform-connectivity/connectivity.bicep' = {
  name: 'deploy-connectivity'
  params: {
    location: location
    tags: {
      workload: 'azure-landing-zone'
      topic: 'platform-connectivity'
      environment: 'prod'
    }
    nsgs: nsgs
    namingConvention: namingConvention
  }
  scope: subscription(subIdPlatformConnectivity)
}
