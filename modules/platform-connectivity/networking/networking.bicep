targetScope = 'resourceGroup'

metadata name = 'Azure Landing Zone - Hub Networking'
metadata description = 'Hub virtual network and connectivity resources for Azure Landing Zone'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the virtual network.')
param vnetName string = 'vnet-hub-prod-${location}-001'

@description('Hub virtual network.')
resource hubVnet 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.1.2.0/24'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.3.0/24'
        }
      }
    ]
  }
  tags: {
    workload: 'azure-landing-zone'
    environment: 'prod'
  }
}

output hubVnetId string = hubVnet.id
