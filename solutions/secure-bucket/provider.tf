provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = local.deployment_region
}
