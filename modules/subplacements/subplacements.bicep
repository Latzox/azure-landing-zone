targetScope = 'tenant'

metadata name = 'Azure Landing Zone - Subscription placements'
metadata description = 'Module to create subscription placements for Azure Landing Zone'

@description('The subscription ID of the platform connectivity subscription')
param subIdPlatformConnectivity string = 'b1599fde-3d26-4a36-ace3-bc50ae012b5e'

@description('The subscription ID of the platform identity subscription')
param subIdPlatformIdentity string = 'c2678acf-6c55-482b-9021-8d2021597bb9'

@description('The subscription ID of the platform management subscription')
param subIdPlatformManagement string = 'd37e765a-8e22-40c7-b9f7-fb84e9eb90a6'

@description('The subscription ID of the sandbox subscription')
param subIdSandbox string = 'e48f864b-f420-4f5f-b4c0-d4d7e8401732'

@description('The definition of the subscription placements')
param subPlacementDefinition array = [
  {
    subscriptionId: subIdPlatformConnectivity
    managementGroupId: 'mg-platform-connectivity'
  }
  {
    subscriptionId: subIdPlatformIdentity
    managementGroupId: 'mg-platform-identity'
  }
  {
    subscriptionId: subIdPlatformManagement
    managementGroupId: 'mg-platform-management'
  }
  {
    subscriptionId: subIdSandbox
    managementGroupId: 'mg-sandbox'
  }
]

@description('The subscription placements')
resource subPlacements 'Microsoft.Management/managementGroups/subscriptions@2023-04-01' = [for placement in subPlacementDefinition: {
  name: '${placement.managementGroupId}/${placement.subscriptionId}'
}]
