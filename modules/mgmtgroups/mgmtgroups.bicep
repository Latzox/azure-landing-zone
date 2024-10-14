targetScope = 'tenant'

@description('The root management group id for the tenant')
param tenantRootGroupId string = '310c844d-a4ce-41f0-88f8-216f95f1cf44'

resource tenantRootGroup 'Microsoft.Management/managementGroups@2023-04-01' existing = {
  name: tenantRootGroupId
}

@description('Management group for Azure Landing Zones')
resource azureLandingZones 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-alz'
  properties: {
    displayName: 'Azure Landing Zones'
    details: {
      parent: tenantRootGroup
    }
  }
}

@description('Management group for Landing Zones')
resource landingZones 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-landingzones'
  properties: {
    displayName: 'Landing Zones'
    details: {
      parent: azureLandingZones
    }
  }
}

@description('Management group for Platform')
resource platform 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform'
  properties: {
    displayName: 'Platform'
    details: {
      parent: azureLandingZones
    }
  }
}

@description('Management group for Connectivity')
resource connectivity 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-connectivity'
  properties: {
    displayName: 'Connectivity'
    details: {
      parent: platform
    }
  }
}

@description('Management group for Identity')
resource identity 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-identity'
  properties: {
    displayName: 'Identity'
    details: {
      parent: platform
    }
  }
}

@description('Management group for Management')
resource management 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-management'
  properties: {
    displayName: 'Management'
    details: {
      parent: platform
    }
  }
}

@description('Management group for Security')
resource sandbox 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-sandbox'
  properties: {
    displayName: 'Sandbox'
    details: {
      parent: tenantRootGroup
    }
  }
}
