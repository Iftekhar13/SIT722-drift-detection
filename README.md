# Automated Terraform Configuration Drift Detection and Remediation

This project demonstrates an automated approach for detecting and handling configuration drift in Microsoft Azure using Terraform and GitHub Actions.

## Project Goal

The goal of this project is to identify when an Azure resource has been manually changed and no longer matches the Terraform configuration.

Instead of only reporting the difference, the workflow can:

1. Detect configuration drift.
2. Send a notification to Discord.
3. Automatically restore the Azure resource to the Terraform-defined state.
4. Verify that the remediation was successful.
5. Send a success or failure notification.

## How It Works

The Terraform configuration defines the expected Azure infrastructure.

A GitHub Actions workflow runs `terraform plan -detailed-exitcode` to compare the expected Terraform configuration with the actual Azure environment.

Terraform returns different exit codes:

- `0` - no changes detected
- `1` - Terraform error
- `2` - infrastructure changes detected

When exit code `2` is returned, the workflow identifies configuration drift.

The workflow then sends an alert to Discord and runs Terraform to restore the Azure infrastructure to its expected state.

A second Terraform plan is performed after remediation to confirm that no drift remains.

## Workflow

Terraform Configuration  
↓  
GitHub Actions  
↓  
Check Azure infrastructure  
↓  
Configuration drift detected?  
↓  
Send Discord alert  
↓  
Automatic Terraform remediation  
↓  
Verify infrastructure  
↓  
Send success or failure notification

## Technologies Used

- Terraform
- Microsoft Azure
- Azure Blob Storage
- GitHub
- GitHub Actions
- Discord Webhooks

## Remote Terraform State

The Terraform state is stored remotely in Azure Blob Storage.

This allows both the local development environment and the GitHub Actions runner to use the same Terraform state when checking the Azure infrastructure.

## Automated and Manual Execution

The workflow supports two methods of execution:

- Scheduled automatic drift checks
- Manual execution through GitHub Actions

The scheduled workflow allows the infrastructure to be checked regularly without requiring a developer to manually run Terraform.

## Demonstration

The project can be demonstrated using the following process:

1. Terraform defines the Azure resource with the tag `environment = development`.
2. The Azure resource is manually changed to `environment = production`.
3. GitHub Actions runs the Terraform drift check.
4. Terraform detects the difference.
5. A Discord alert is sent.
6. Terraform automatically restores the tag to `development`.
7. Another Terraform plan verifies that the infrastructure matches the configuration.
8. A remediation success message is sent to Discord.

## Security

Sensitive information such as Azure credentials, the Terraform backend access key and Discord webhook URL are stored using GitHub Actions repository secrets.

They are not stored directly in the source code.

## Extension Beyond Basic Terraform Usage

This project extends basic Terraform infrastructure provisioning by introducing automated infrastructure monitoring and recovery.

The main extensions include:

- remote Terraform state using Azure Blob Storage
- automated drift detection
- Terraform detailed exit-code handling
- conditional GitHub Actions workflow logic
- Discord webhook integration
- automatic drift remediation
- post-remediation verification
- remediation failure notification