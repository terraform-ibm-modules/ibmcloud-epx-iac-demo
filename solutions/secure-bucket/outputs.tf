##############################################################################
# Outputs
##############################################################################

output "s3_endpoint_direct" {
  description = "The s3 direct endpoint of the created bucket."
  value       = try(module.cos.s3_endpoint_direct, null)
}

output "s3_endpoint_private" {
  description = "The s3 private endpoint of the created bucket."
  value       = try(module.cos.s3_endpoint_private, null)
}

output "bucket_name" {
  description = "The name of the bucket that was created (includes random suffix)."
  value       = try(module.cos.bucket_name, null)
}

output "bucket_crn" {
  description = "The CRN of the bucket that was created."
  value       = try(module.cos.bucket_crn, null)
}

output "cos_instance_crn" {
  description = "The CRN of the COS instance containing the bucket."
  value       = module.cos.cos_instance_crn
}
