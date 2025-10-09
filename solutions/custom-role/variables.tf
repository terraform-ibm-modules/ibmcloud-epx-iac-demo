##############################################################################
# Input Variables for Secure COS Bucket Demo DA
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key to deploy resources."
  sensitive   = true
}

variable "role_name" {
  type        = string
  description = "The name for your new custom role."
}

variable "role_display_name" {
  type        = string
  description = "The display name of the custom role. If not set will default to the role_name supplied."
  default     = null
}

variable "service_name" {
  type        = string
  description = "The name of the service for which you want to create the custom role."
}

variable "role_description" {
  type        = string
  description = "Description of the custom role. Make sure to include information about the level of access this role assignment gives a user."
  default     = null
}

variable "action_list" {
  type        = string
  description = "A linefeed separated list of action IDs that you want to add to your custom role. The action IDs vary by service."
}

