[![Integration](https://github.com/Latzox/azure-landing-zone/actions/workflows/integration.yml/badge.svg)](https://github.com/Latzox/azure-landing-zone/actions/workflows/integration.yml)

# Azure Landing Zone

This repository contains Bicep modules to set up a preconfigured Azure landing zone, ensuring best practices are followed. Azure landing zones are essential for establishing a well-governed environment in Azure. They provide a foundation for building and scaling your Azure resources effectively and securely.

## Parameters

| Name                           | Type   | Description                                                                      | Default Value                                                                                        |
| ------------------------------ | ------ | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| location                       | string | Location for all resources.                                                      | switzerlandnorth                                                                                     |
| namingConvention               | object | Naming convention for all resources.                                             | {<br>    "resourceGroupPlatformLogging": "rg-platformlogging-prod-001",<br>    "resourceGroupHubVnet": "rg-hubvnet-prod-001",<br>    "resourceGroupPrivateDns": "rg-privatedns-prod-001",<br>    "managementLogAnalyticsWorkspace": "law-platform-prod-001",<br>    "connectivityHubVNetName": "vnet-hub-prod-${location}-001",<br>    "connectivityPrivatednsZoneName": "cloud.latzo.ch"<br>} |
| nsgs                           | array  | Network security group names for platform connectivity.                          | [ <br>    "nsg-hub-gateway-prod-001", <br>    "nsg-hub-firewall-prod-001", <br>    "nsg-hub-bastion-prod-001" <br>] |
| tenantRootGroupId              | string | The root management group id for the tenant.                                     | 310c844d-a4ce-41f0-88f8-216f95f1cf44                                                                 |
| roleDefinitionsAssignableScope | string | The management group scope to which the custom role definitions can be assigned. | mg-alz                                                                                               |
| subIdPlatformConnectivity      | string | The subscription ID of the platform connectivity subscription.                   | b1599fde-3d26-4a36-ace3-bc50ae012b5e                                                                 |
| subIdPlatformIdentity          | string | The subscription ID of the platform identity subscription.                       | c2678acf-6c55-482b-9021-8d2021597bb9                                                                 |
| subIdPlatformManagement        | string | The subscription ID of the platform management subscription.                     | d37e765a-8e22-40c7-b9f7-fb84e9eb90a6                                                                 |
| subIdSandbox                   | string | The subscription ID of the sandbox subscription.                                 | e48f864b-f420-4f5f-b4c0-d4d7e8401732                                                                 |
| platformLoggingRetentionDays   | int    | Retention days for platform logging.                                             | 120                                                                                                  |
| platformLogAnalyticsSku        | string | The SKU for the platform Log Analytics workspace.                                | PerGB2018                                                                                            |

## Getting Started

To deploy the landing zone, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/latzox/azure-landing-zone.git
   ```
2. **Navigate to the directory:**

   ```bash
   cd azure-landing-zone
   ```
3. **Deploy the Bicep modules using Azure CLI:**

   ```bash
   az deployment tenant create --name alz --location <YourLocation> --template-file main.bicep --parameters main.parameters.json
   ```
4. **Customize the deployment parameters as needed.**

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.