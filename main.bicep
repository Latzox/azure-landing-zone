targetScope = 'tenant'

metadata name = 'Azure Landing Zone'
metadata description = 'Automatic setup of an Azure Landing Zone'

@description('The root management group id for the tenant')
param tenantRootGroupId string

@description('The subscription ID of the platform connectivity subscription')
param subIdPlatformConnectivity string

@description('The subscription ID of the platform identity subscription')
param subIdPlatformIdentity string

@description('The subscription ID of the platform management subscription')
param subIdPlatformManagement string

@description('The subscription ID of the sandbox subscription')
param subIdSandbox string

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
  scope: managementGroup('mg-alz')
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
