[![Integration](https://github.com/Latzox/azure-landing-zone/actions/workflows/integration.yml/badge.svg)](https://github.com/Latzox/azure-landing-zone/actions/workflows/integration.yml)

# Azure Landing Zone

This repository contains Bicep modules to set up a preconfigured Azure landing zone.

## Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Modules](#modules)
4. [Contributing](#contributing)
5. [License](#license)

## Introduction

Azure landing zones are essential for establishing a well-governed environment in Azure. They provide a foundation for building and scaling your Azure resources effectively and securely.

This repository contains Bicep modules designed to deploy a preconfigured Azure landing zone, ensuring best practices are followed.

## Getting Started

To deploy the landing zone, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/azure-landing-zone.git
   ```
2. **Navigate to the directory:**

   ```bash
   cd azure-landing-zone
   ```
3. **Deploy the Bicep modules using Azure CLI:**

   ```bash
   az deployment sub create --template-file main.bicep --location <YourLocation>
   ```
4. **Customize the deployment parameters as needed.**

## Modules

The repository contains the following modules:

- **Networking:** Sets up virtual networks, subnets, and network security groups.
- **Identity:** Configures Azure Active Directory integration, role-based access control (RBAC), and policies.
- **Management:** Deploys monitoring solutions, log analytics, and automation accounts.
- **Security:** Implements security best practices, including Azure Security Center and key vault configurations.
- **Governance:** Establishes resource groups, naming conventions, and tagging policies.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.