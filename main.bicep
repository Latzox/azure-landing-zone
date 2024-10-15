targetScope = 'tenant'

metadata name = 'Azure Landing Zone'
metadata description = 'Automatic setup of an Azure Landing Zone'

@description('Location for all resources.')
param location string = 'switzerlandnorth'

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
  }
}

@description('Deploy platform connectivity')
module connectivity 'modules/platform-connectivity/connectivity.bicep' = {
  name: 'deploy-connectivity'
  params: {
    location: 'switzerlandnorth'
  }
  scope: subscription(subIdPlatformConnectivity)
}
