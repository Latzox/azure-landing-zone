targetScope = 'managementGroup'

metadata name = 'Azure Landing Zone - Custom Role Definitions'
metadata description = 'Custom role definitions for Azure Landing Zone'

@description('Custom role definition for subscription owner')
resource applicationOwnerRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(tenant().tenantId, 'ApplicationOwner')
  properties: {
    roleName: 'ALZ Application Owner'
    description: 'Full access to manage application resources'
    type: 'CustomRole'
    assignableScopes: [
      '/providers/Microsoft.Management/managementGroups/${managementGroup().name}'
    ]
    permissions: [
      {
        actions: [
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Resources/subscriptions/resourceGroups/write'
          'Microsoft.Web/sites/read'
          'Microsoft.Web/sites/write'
          'Microsoft.Web/serverfarms/read'
          'Microsoft.Web/serverfarms/write'
        ]
        notActions: []
      }
    ]
  }
}

@description('Custom role definition for subscription owner')
resource subscriptionOwnerRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(tenant().tenantId, 'SubscriptionOwner')
  properties: {
    roleName: 'ALZ Subscription Owner'
    description: 'Full access to manage subscription resources'
    type: 'CustomRole'
    assignableScopes: [
      '/providers/Microsoft.Management/managementGroups/${managementGroup().name}'
    ]
    permissions: [
      {
        actions: [
          'Microsoft.Resources/subscriptions/read'
          'Microsoft.Resources/subscriptions/write'
          'Microsoft.Authorization/roleAssignments/read'
          'Microsoft.Authorization/roleAssignments/write'
        ]
        notActions: []
      }
    ]
  }
}

@description('Custom role definition for security operations')
resource securityOperationsRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(tenant().tenantId, 'SecurityOperations')
  properties: {
    roleName: 'ALZ Security Operations'
    description: 'Access to monitor and manage security operations'
    type: 'CustomRole'
    assignableScopes: [
      '/providers/Microsoft.Management/managementGroups/${managementGroup().name}'
    ]
    permissions: [
      {
        actions: [
          'Microsoft.Security/*/read'
          'Microsoft.Insights/alertRules/read'
          'Microsoft.Insights/alertRules/write'
          'Microsoft.OperationalInsights/workspaces/read'
          'Microsoft.OperationalInsights/workspaces/query'
        ]
        notActions: []
      }
    ]
  }
}

@description('Custom role definition for network management')
resource networkManagementRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(tenant().tenantId, 'NetworkManagement')
  properties: {
    roleName: 'ALZ Network Management'
    description: 'Full access to manage network resources'
    type: 'CustomRole'
    assignableScopes: [
      '/providers/Microsoft.Management/managementGroups/${managementGroup().name}'
    ]
    permissions: [
      {
        actions: [
          'Microsoft.Network/networkInterfaces/read'
          'Microsoft.Network/networkInterfaces/write'
          'Microsoft.Network/virtualNetworks/read'
          'Microsoft.Network/virtualNetworks/write'
        ]
        notActions: []
      }
    ]
  }
}
