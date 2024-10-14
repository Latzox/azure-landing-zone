targetScope = 'resourceGroup'

@description('Name of the private DNS zone.')
param privatednsZoneName string = 'cloud.latzo.ch'

@description('Name of the virtual network link to the private DNS zone.')
param dnsVnetLinkName string = 'hubvnetlink'

@description('Virtual network ID to link to the private DNS zone.')
param vnetId string

@description('The private DNS zone.')
resource privatednszone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privatednsZoneName
  location: resourceGroup().location

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
}
