targetScope = 'tenant'

metadata name = 'Azure Landing Zone'
metadata description = 'Automatic setup of an Azure Landing Zone'

@description('The root management group id for the tenant')
param tenantRootGroupId string

@description('Deploy management groups')
module mgmtgroups 'modules/mgmtgroups/mgmtgroups.bicep' = {
  name: 'deploy-mgmtgroups'
  params: {
    tenantRootGroupId: tenantRootGroupId
  }
}

@description('Deploy role definitions')
module roledefinitions 'modules/roledefinitions/roledefinitions.bicep' = {
  name: 'deploy-roledefinitions'
  scope: managementGroup('mg-alz')
}
