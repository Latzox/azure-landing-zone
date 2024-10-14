targetScope = 'tenant'

metadata name = 'Azure Landing Zone - Subscription placements'
metadata description = 'Module to create subscription placements for Azure Landing Zone'

@description('The subscription ID of the platform connectivity subscription')
param subIdPlatformConnectivity string

@description('The subscription ID of the platform identity subscription')
param subIdPlatformIdentity string

@description('The subscription ID of the platform management subscription')
param subIdPlatformManagement string

@description('The subscription ID of the sandbox subscription')
param subIdSandbox string

var subPlacementDefinition = [
  {
    name: 'sp-platform-connectivity'
    subscriptionId: subIdPlatformConnectivity
    managementGroupId: 'mg-platform-connectivity'
  }
  {
    name: 'sp-platform-identity'
    subscriptionId: subIdPlatformIdentity
    managementGroupId: 'mg-platform-identity'
  }
  {
    name: 'sp-platform-management'
    subscriptionId: subIdPlatformManagement
    managementGroupId: 'mg-platform-management'
  }
  {
    name: 'sp-sandbox'
    subscriptionId: subIdSandbox
    managementGroupId: 'mg-sandbox'
  }
]

resource subPlacements 'Microsoft.Management/managementGroups/subscriptions@2023-04-01' = [for placement in subPlacementDefinition: {
  name: '${placement.managementGroupId}/${placement.subscriptionId}'
}]
