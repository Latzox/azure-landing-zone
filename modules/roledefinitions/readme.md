# Role Definitions for Azure Landing Zone

This module defines custom role definitions for an Azure Landing Zone.

## Parameters

- `managementGroup`: The ID of the management group where the roles will be assigned. This parameter is required.

## Outputs

This module does not generate any outputs.

## Usage

To use the module in your Bicep file, follow these steps:

```Bicep
@description('Deploy role definitions')
module roledefinitions 'modules/roledefinitions/roledefinitions.bicep' = {
  name: 'deploy-roledefinitions'
  scope: managementGroup('mg-alz')
}
```