targetScope = 'resourceGroup'

@description('Tags for all resources.')
param tags object

@description('Name of the private DNS zone.')
param privatednsZoneName string

@description('Name of the virtual network link to the private DNS zone.')
param dnsVnetLinkName string

@description('Virtual network ID to link to the private DNS zone.')
param vnetId string

@description('The private DNS zone.')
resource privatednszone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privatednsZoneName
  location: resourceGroup().location
  tags: tags
}

@description('Virtual network link to the private DNS zone.')
resource hubvnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: dnsVnetLinkName
  location: 'Global'
  parent: privatednszone
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: vnetId
    }
  }
  tags: tags
}
