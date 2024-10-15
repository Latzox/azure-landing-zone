targetScope = 'tenant'

metadata name = 'Azure Landing Zone - Custom Role Definitions'
metadata description = 'Custom role definitions for Azure Landing Zone'

@description('The management group scope to which the role can be assigned.')
param roleDefinitionsAssignableScope string

@description('Custom role definition for application owner')
resource applicationOwnerRole 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' = {
  name: guid(tenant().tenantId, 'ApplicationOwner')
  properties: {
    roleName: 'ALZ Application Owner'
    description: 'Contributor role granted for application/operations team at resource group level.'
    type: 'CustomRole'
    permissions: [
      {
        actions: [
          '*'
        ]
        notActions: [
          'Microsoft.Authorization/*/write'
          'Microsoft.Network/publicIPAddresses/write'
          'Microsoft.Network/virtualNetworks/write'
          'Microsoft.KeyVault/locations/deletedVaults/purge/action'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', roleDefinitionsAssignableScope)
    ]
  }
}

@description('Custom role definition for subscription owner')
resource subscriptionOwnerRole 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' = {
  name: guid(tenant().tenantId, 'SubscriptionOwner')
  properties: {
    roleName: 'ALZ Subscription Owner'
    description: 'Delegated role for subscription owner derived from subscription Owner role.'
    type: 'CustomRole'
    permissions: [
      {
        actions: [
          '*'
        ]
        notActions: [
          'Microsoft.Authorization/*/write'
          'Microsoft.Network/vpnGateways/*'
          'Microsoft.Network/expressRouteCircuits/*'
          'Microsoft.Network/routeTables/write'
          'Microsoft.Network/vpnSites/*'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', roleDefinitionsAssignableScope)
    ]
  }
}

@description('Custom role definition for security operations')
resource securityOperationsRole 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' = {
  name: guid(tenant().tenantId, 'SecurityOperations')
  properties: {
    roleName: 'ALZ Security Operations'
    description: 'Security administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy.'
    type: 'CustomRole'
    permissions: [
      {
        actions: [
          '*/read'
          '*/register/action'
          'Microsoft.KeyVault/locations/deletedVaults/purge/action'
          'Microsoft.PolicyInsights/*'
          'Microsoft.Authorization/policyAssignments/*'
          'Microsoft.Authorization/policyDefinitions/*'
          'Microsoft.Authorization/policyExemptions/*'
          'Microsoft.Authorization/policySetDefinitions/*'
          'Microsoft.Insights/alertRules/*'
          'Microsoft.Resources/deployments/*'
          'Microsoft.Security/*'
          'Microsoft.Support/*'
        ]
        notActions: []
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', roleDefinitionsAssignableScope)
    ]
  }
}

@description('Custom role definition for network management')
resource networkManagementRole 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' = {
  name: guid(tenant().tenantId, 'NetworkManagement')
  properties: {
    roleName: 'ALZ Network Management'
    description: 'Platform-wide global connectivity management: Virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others.'
    type: 'CustomRole'
    permissions: [
      {
        actions: [
          '*/read'
          'Microsoft.Network/*'
          'Microsoft.Resources/deployments/*'
          'Microsoft.Support/*'
        ]
        notActions: []
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', roleDefinitionsAssignableScope)
    ]
  }
}
