targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Connectivity'
metadata description = 'Hub virtual network and connectivity resources for Azure Landing Zone'

@description('Location for all resources.')
param location string = 'switzerlandnorth'

@description('Resource group for the hub virtual network.')
resource rg 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-hubvnet-prod-001'
  location: location
}

@description('Resource group for the private dns zone.')
resource rg2 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-privatedns-prod-001'
  location: location
}

@description('Hub virtual network.')
module hubNetworking 'networking/networking.bicep' = {
  name: 'deploy-hub-networking'
  scope: rg
}

@description('Private DNS zone.')
module privateDns 'dns/privatedns.bicep' = {
  name: 'deploy-privatedns'
  scope: rg2
  params: {
    vnetId: hubNetworking.outputs.hubVnetId
  }
  dependsOn: [
    hubNetworking
  ]
}
