targetScope = 'resourceGroup'

metadata name = 'Azure Landing Zone - Hub Networking'
metadata description = 'Hub virtual network and connectivity resources for Azure Landing Zone'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the virtual network.')
param vnetName string = 'vnet-hub-prod-${location}-001'

@description('Network security group names.')
var nsgs = [
  'nsg-hub-gateway-prod-001'
  'nsg-hub-firewall-prod-001'
  'nsg-hub-bastion-prod-001'
]

@description('The Network security groups.')
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-01-01' = [
  for nsg in nsgs: {
    name: nsg
    location: location
    tags: {
      workload: 'azure-landing-zone'
      environment: 'prod'
    }
    properties: {
      securityRules: [
        {
          name: 'deny-hop-outbound'
          properties: {
            priority: 200
            access: 'Deny'
            protocol: 'Tcp'
            direction: 'Outbound'
            sourceAddressPrefix: 'VirtualNetwork'
            destinationAddressPrefix: '*'
            destinationPortRanges: [
              '3389'
              '22'
            ]
          }
        }
      ]
    }
  }
]

@description('Hub virtual network.')
resource hubVnet 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: vnetName
  location: location
  tags: {
    workload: 'azure-landing-zone'
    environment: 'prod'
  }
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
          networkSecurityGroup: {
            id: networkSecurityGroup[0].id
          }
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.1.2.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup[1].id
          }
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.3.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup[2].id
          }
        }
      }
    ]
  }
}

output hubVnetId string = hubVnet.id
