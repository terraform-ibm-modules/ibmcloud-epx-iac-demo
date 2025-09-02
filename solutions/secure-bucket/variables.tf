##############################################################################
# Input Variables for Secure COS Bucket Demo DA
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key to deploy resources."
  sensitive   = true
}

variable "bucket_name" {
  type        = string
  description = "The name for the secure COS bucket. A random suffix will be added automatically."
}

variable "existing_kms_key_crn" {
  type        = string
  description = "The CRN of the existing KMS key for bucket encryption."
}

variable "owner_contact_tag" {
  type        = string
  description = "Contact info that will be used as part of an `owner-contact:` COS Instance tag."

  validation {
    condition = alltrue([
      length(regexall("^owner-contact:", var.owner_contact_tag)) == 0,
      length(regexall("[:]", var.owner_contact_tag)) == 0
    ])
    error_message = "Owner Contact should not contain the `owner-contact:` tag prefix, as this will be applied with this solution."
  }

  validation {
    condition     = length(var.owner_contact_tag) > 0
    error_message = "Technical Contact must be supplied and cannot be empty"
  }
}

variable "technical_contact_tag" {
  type        = string
  description = "Contact info that will be used as part of an `tech-contact:` COS Instance tag."

  validation {
    condition = alltrue([
      length(regexall("^tech-contact:", var.technical_contact_tag)) == 0,
      length(regexall("[:]", var.technical_contact_tag)) == 0
    ])
    error_message = "Technical Contact should not contain the `technical-contact:` tag prefix, as this will be applied with this solution."
  }

  validation {
    condition     = length(var.technical_contact_tag) > 0
    error_message = "Technical Contact must be supplied and cannot be empty"
  }
}

variable "cos_instance_tags" {
  type        = list(string)
  description = "General tags to place on the COS instance, not including the `owner-contact` or `tech-contact`."
  default     = []
  nullable    = false
}
