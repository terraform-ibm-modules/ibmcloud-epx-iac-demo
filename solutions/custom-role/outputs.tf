##############################################################################
# Outputs
##############################################################################

output "custom_role_crn" {
  description = "The CRN of the custom role that was created."
  value       = ibm_iam_custom_role.custom.crn
}

output "custom_role_id" {
  description = "The CRN of the custom role that was created."
  value       = ibm_iam_custom_role.custom.id
}
