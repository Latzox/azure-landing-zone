// This Bicep file is used to create the management groups in the tenant root group

// The scope of the deployment is the tenant
targetScope = 'tenant'

@secure()
@description('The root management group id for the tenant')
param tenantRootGroupId string

resource tenantRootGroup 'Microsoft.Management/managementGroups@2021-04-01' existing = {
  name: tenantRootGroupId
}

resource azureLandingZones 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-alz'
  properties: {
    displayName: 'Azure Landing Zones'
    details: {
      parent: tenantRootGroup
    }
  }
}

resource landingZones 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-landingzones'
  properties: {
    displayName: 'Landing Zones'
    details: {
      parent: azureLandingZones
    }
  }
}

resource platform 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform'
  properties: {
    displayName: 'Platform'
    details: {
      parent: azureLandingZones
    }
  }
}

resource connectivity 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-connectivity'
  properties: {
    displayName: 'Connectivity'
    details: {
      parent: platform
    }
  }
}

resource identity 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-identity'
  properties: {
    displayName: 'Identity'
    details: {
      parent: platform
    }
  }
}

resource management 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: 'mg-platform-management'
  properties: {
    displayName: 'Management'
    details: {
      parent: platform
    }
  }
}

resource sandbox 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-sandbox'
  properties: {
    displayName: 'Sandbox'
    details: {
      parent: tenantRootGroup
    }
  }
}
