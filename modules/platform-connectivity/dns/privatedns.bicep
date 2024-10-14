targetScope = 'resourceGroup'

@description('Name of the private DNS zone.')
param privatednsZoneName string = 'cloud.latzo.ch'

@description('Name of the virtual network link to the private DNS zone.')
param dnsVnetLinkName string = 'hubvnetlink'

@description('Virtual network ID to link to the private DNS zone.')
param vnetId string = '/subscriptions/e48f864b-f420-4f5f-b4c0-d4d7e8401732/providers/Microsoft.Network/virtualNetworks/hub-vnet'

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
