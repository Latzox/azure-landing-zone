# Management Groups for Azure Landing Zone

This Bicep module creates management groups within the tenant root group in Azure.

## Parameters

- **tenantRootGroupId (string):** The root management group id for the tenant. This parameter is required and should be kept secure.

## Outputs

This module does not generate outputs. However, you can monitor the creation of management groups through the Azure portal or Azure CLI.

## Usage

To use the module in your Bicep file, follow these steps:

1. **Reference the module:**

   ```bicep
   module mgmtGroups 'modules/mgmtgroups/mgmtgroups.bicep' = {
   	name: 'managementGroupsDeployment'
   	params: {
   		tenantRootGroupId: '<YourTenantRootGroupId>'
   	}
   }
   ```
2. **Deploy the Bicep module using Azure CLI:**

   ```bash
   az deployment tenant create --template-file mgmtgroups.bicep --parameters tenantRootGroupId=<YourTenantRootGroupId>
   ```
3. **Customize the deployment parameters as needed.**