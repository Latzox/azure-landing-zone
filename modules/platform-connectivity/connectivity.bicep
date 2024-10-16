targetScope = 'subscription'

metadata name = 'Azure Landing Zone - Connectivity'
metadata description = 'Hub virtual network and connectivity resources for Azure Landing Zone'

@description('Location for all resources.')
param location string

@description('Naming convention for all resources.')
param namingConvention object

@description('Network security group names.')
param nsgs array

@description('Tags for all resources.')
param tags object

@description('Resource group for the hub virtual network.')
resource rgHubVnet 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-hubvnet-prod-001'
  location: location
  tags: tags
}

@description('Resource group for the private dns zone.')
resource rgPrivateDns 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'rg-privatedns-prod-001'
  location: location
  tags: tags
}

@description('Hub virtual network.')
module hubNetworking 'networking/networking.bicep' = {
  name: 'deploy-hub-networking'
  scope: rgHubVnet
  params: {
    tags: tags
    location: location
    nsgs: nsgs
    namingConvention: namingConvention
  }
}

@description('Private DNS zone.')
module privateDns 'dns/privatedns.bicep' = {
  name: 'deploy-privatedns'
  scope: rgPrivateDns
  params: {
    vnetId: hubNetworking.outputs.hubVnetId
    tags: tags
    namingConvention: namingConvention
    dnsVnetLinkName: 'hubvnetlink'
  }
  dependsOn: [
    hubNetworking
  ]
}
