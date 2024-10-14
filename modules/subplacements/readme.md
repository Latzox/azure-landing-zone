# Azure Landing Zone - Subscription Placements

This module creates subscription placements for Azure Landing Zone.

## Parameters

- `subIdPlatformConnectivity`: The subscription ID of the platform connectivity subscription.
- `subIdPlatformIdentity`: The subscription ID of the platform identity subscription.
- `subIdPlatformManagement`: The subscription ID of the platform management subscription.
- `subIdSandbox`: The subscription ID of the sandbox subscription.

## Outputs

Currently, this module does not produce any outputs. Future updates might include output parameters as needed.

## Usage

```bicep
@description('Deploy subscription placements')
module subPlacements 'modules/subplacements/subplacements.bicep' = {
  name: 'deploy-subplacements'
  params: {
    subIdPlatformConnectivity: subIdPlatformConnectivity
    subIdPlatformIdentity: subIdPlatformIdentity
    subIdPlatformManagement: subIdPlatformManagement
    subIdSandbox: subIdSandbox
  }
}
```