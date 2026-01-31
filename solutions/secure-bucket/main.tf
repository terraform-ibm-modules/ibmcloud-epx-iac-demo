##############################################################################
# Secure COS Bucket Demo - Minimal DA for Private Catalog Demo
##############################################################################

locals {
  # example of a forced (hard-coded) region
  deployment_region = "br-sao"
}

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.7"
  # could be input variable, or could be set here to force specific resource group
  existing_resource_group_name = "Default"
}

#######################################################################################################################
# KMS Key
#######################################################################################################################
module "kms_key_crn_parser" {
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.4.1"
  crn     = var.existing_kms_key_crn
}

locals {
  existing_kms_instance_guid = module.kms_key_crn_parser.service_instance
  kms_key_crn                = var.existing_kms_key_crn
}

#######################################################################################################################
# COS Instance
#######################################################################################################################

locals {
  # COS INSTANCE TAGS
  # create the required owner and tech contact tags with appropriate prefix.
  # add owner/tech tags to list of general tags.
  cos_owner_tag      = "owner-contact:${var.owner_contact_tag}"
  cos_tech_tag       = "tech-contact:${var.technical_contact_tag}"
  final_cos_tag_list = concat(var.cos_instance_tags, [local.cos_owner_tag, local.cos_tech_tag])
}

module "cos" {
  source            = "terraform-ibm-modules/cos/ibm"
  version           = "10.9.9"
  resource_group_id = module.resource_group.resource_group_id
  cos_instance_name = "${var.bucket_name}-cos"
  cos_tags          = local.final_cos_tag_list

  # example of forcing a prefix or suffix for naming
  bucket_name            = "demo-${var.bucket_name}"
  add_bucket_name_suffix = true

  # force encryption
  kms_encryption_enabled        = true
  existing_kms_instance_guid    = local.existing_kms_instance_guid
  kms_key_crn                   = local.kms_key_crn
  skip_iam_authorization_policy = true

  # force region
  region = local.deployment_region

  # keep endpoints private (internal IBM Cloud traffic only)
  management_endpoint_type_for_bucket = "private"

  # force some of the bucket properties including lifecycle
  bucket_storage_class      = "standard"
  force_delete              = false
  hard_quota                = 107374182400 # 100 GB limit
  object_locking_enabled    = true
  object_lock_duration_days = 30 # 1 month immutable

  archive_days = 30
  archive_type = "Glacier"

  expire_days = 365 # Delete after 1 year

  object_versioning_enabled = true

  # could also include other bucket lifecycle and monitoring settings such as
  # - activity tracking
  # - metrics monitoring
  # - retention rule
}
