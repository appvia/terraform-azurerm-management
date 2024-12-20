variable "root_id" {
  type        = string
  description = "Sets the value used for generating unique resource naming within the module."
  default     = "alz"
}

variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
}

variable "management_resources_tags" {
  type        = map(string)
  description = "Specify tags to add to \"management\" resources."
  default = {
    WorkloadName        = "ALZ.Management"
    DataClassification  = "General"
    BusinessCriticality = "Mission-critical"
    BusinessUnit        = "Platform Operations"
    OperationsTeam      = "Platform Operations"
  }
}

variable "management_resources_configuration" {
  type = object({
    settings = optional(object({
      ama = optional(object({
        enable_uami                                                         = optional(bool, true)
        enable_vminsights_dcr                                               = optional(bool, true)
        enable_change_tracking_dcr                                          = optional(bool, true)
        enable_mdfc_defender_for_sql_dcr                                    = optional(bool, true)
        enable_mdfc_defender_for_sql_query_collection_for_security_research = optional(bool, true)
      }), {})
      log_analytics = optional(object({
        enabled = optional(bool, true)
        config = optional(object({
          daily_quota_gb                         = optional(number, -1)
          retention_in_days                      = optional(number, 30)
          enable_monitoring_for_vm               = optional(bool, true)
          enable_monitoring_for_vmss             = optional(bool, true)
          enable_sentinel                        = optional(bool, true)
          enable_change_tracking                 = optional(bool, true)
          enable_solution_for_vm_insights        = optional(bool, true)
          enable_solution_for_container_insights = optional(bool, true)
          sentinel_customer_managed_key_enabled  = optional(bool, false) # not used at this time
        }), {})
      }), {})
      security_center = optional(object({
        enabled = optional(bool, true)
        config = optional(object({
          email_security_contact                                = optional(string, "security_contact@replace_me")
          enable_defender_for_app_services                      = optional(bool, true)
          enable_defender_for_arm                               = optional(bool, true)
          enable_defender_for_containers                        = optional(bool, true)
          enable_defender_for_cosmosdbs                         = optional(bool, true)
          enable_defender_for_cspm                              = optional(bool, true)
          enable_defender_for_key_vault                         = optional(bool, true)
          enable_defender_for_oss_databases                     = optional(bool, true)
          enable_defender_for_servers                           = optional(bool, true)
          enable_defender_for_servers_vulnerability_assessments = optional(bool, true)
          enable_defender_for_sql_servers                       = optional(bool, true)
          enable_defender_for_sql_server_vms                    = optional(bool, true)
          enable_defender_for_storage                           = optional(bool, true)
        }), {})
      }), {})
    }), {})
    location = optional(string, "")
    tags     = optional(any, {})
    advanced = optional(any, {})
  })
  description = "Configuration settings for the \"management\" resources."
}
