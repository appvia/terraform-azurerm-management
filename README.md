<!-- markdownlint-disable -->

<a href="https://www.appvia.io/"><img src="./docs/banner.jpg" alt="Appvia Banner"/></a><br/><p align="right"> </a> <a href="https://github.com/appvia/terraform-azure-management/releases/latest"><img src="https://img.shields.io/github/release/appvia/terraform-azure-management.svg?style=for-the-badge&color=006400" alt="Latest Release"/></a> <a href="https://appvia-community.slack.com/join/shared_invite/zt-1s7i7xy85-T155drryqU56emm09ojMVA#/shared-invite/email"><img src="https://img.shields.io/badge/Slack-Join%20Community-purple?style=for-the-badge&logo=slack" alt="Slack Community"/></a> <a href="https://github.com/appvia/terraform-azure-management/graphs/contributors"><img src="https://img.shields.io/github/contributors/appvia/terraform-azure-management.svg?style=for-the-badge&color=FF8C00" alt="Contributors"/></a>

<!-- markdownlint-restore -->
<!--
  ***** CAUTION: DO NOT EDIT ABOVE THIS LINE ******
-->

![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform Azure Landing Zone Management Module

## Description

The module deploys the [management and monitoring](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management) resources from the [conceptual architecture for Azure landing zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture) into the specified subscription, based on the configuration supplied. The module also ensures that the specified subscription is placed in the right management group.

![Management Resources](./docs/management-resources.png)

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.65.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_management_resources_configuration"></a> [management\_resources\_configuration](#input\_management\_resources\_configuration) | Configuration settings for the "management" resources. | <pre>object({<br/>    settings = optional(object({<br/>      ama = optional(object({<br/>        enable_uami                                                         = optional(bool, true)<br/>        enable_vminsights_dcr                                               = optional(bool, true)<br/>        enable_change_tracking_dcr                                          = optional(bool, true)<br/>        enable_mdfc_defender_for_sql_dcr                                    = optional(bool, true)<br/>        enable_mdfc_defender_for_sql_query_collection_for_security_research = optional(bool, true)<br/>      }), {})<br/>      log_analytics = optional(object({<br/>        enabled = optional(bool, true)<br/>        config = optional(object({<br/>          daily_quota_gb                         = optional(number, -1)<br/>          retention_in_days                      = optional(number, 30)<br/>          enable_monitoring_for_vm               = optional(bool, true)<br/>          enable_monitoring_for_vmss             = optional(bool, true)<br/>          enable_sentinel                        = optional(bool, true)<br/>          enable_change_tracking                 = optional(bool, true)<br/>          enable_solution_for_vm_insights        = optional(bool, true)<br/>          enable_solution_for_container_insights = optional(bool, true)<br/>          sentinel_customer_managed_key_enabled  = optional(bool, false) # not used at this time<br/>        }), {})<br/>      }), {})<br/>      security_center = optional(object({<br/>        enabled = optional(bool, true)<br/>        config = optional(object({<br/>          email_security_contact                                = optional(string, "security_contact@replace_me")<br/>          enable_defender_for_app_services                      = optional(bool, true)<br/>          enable_defender_for_arm                               = optional(bool, true)<br/>          enable_defender_for_containers                        = optional(bool, true)<br/>          enable_defender_for_cosmosdbs                         = optional(bool, true)<br/>          enable_defender_for_cspm                              = optional(bool, true)<br/>          enable_defender_for_key_vault                         = optional(bool, true)<br/>          enable_defender_for_oss_databases                     = optional(bool, true)<br/>          enable_defender_for_servers                           = optional(bool, true)<br/>          enable_defender_for_servers_vulnerability_assessments = optional(bool, true)<br/>          enable_defender_for_sql_servers                       = optional(bool, true)<br/>          enable_defender_for_sql_server_vms                    = optional(bool, true)<br/>          enable_defender_for_storage                           = optional(bool, true)<br/>        }), {})<br/>      }), {})<br/>    }), {})<br/>    location = optional(string, "")<br/>    tags     = optional(any, {})<br/>    advanced = optional(any, {})<br/>  })</pre> | n/a | yes |
| <a name="input_primary_location"></a> [primary\_location](#input\_primary\_location) | Sets the location for "primary" resources to be created in. | `string` | n/a | yes |
| <a name="input_management_resources_tags"></a> [management\_resources\_tags](#input\_management\_resources\_tags) | Specify tags to add to "management" resources. | `map(string)` | <pre>{<br/>  "BusinessCriticality": "Mission-critical",<br/>  "BusinessUnit": "Platform Operations",<br/>  "DataClassification": "General",<br/>  "OperationsTeam": "Platform Operations",<br/>  "WorkloadName": "ALZ.Management"<br/>}</pre> | no |
| <a name="input_root_id"></a> [root\_id](#input\_root\_id) | Sets the value used for generating unique resource naming within the module. | `string` | `"alz"` | no |
| <a name="input_use_oidc"></a> [use\_oidc](#input\_use\_oidc) | Set to true to enable OIDC authentication for the Azure connection. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_action_group_id"></a> [action\_group\_id](#output\_action\_group\_id) | Action Group ID for the "management" resources. |
| <a name="output_configuration"></a> [configuration](#output\_configuration) | Configuration settings for the "management" resources. |
| <a name="output_log_analytics_workspace_ids"></a> [log\_analytics\_workspace\_ids](#output\_log\_analytics\_workspace\_ids) | Log Analytics Workspace ID for the "management" resources. |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | Subscription ID for the "management" resources. |
<!-- END_TF_DOCS -->