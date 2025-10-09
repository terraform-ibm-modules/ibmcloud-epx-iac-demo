##############################################################################
# Secure COS Bucket Demo - Minimal DA for Private Catalog Demo
##############################################################################

locals {
  # example of a forced (hard-coded) region
  deployment_region = "br-sao"

  # parse linefeed input into array
  # dev note: separated steps out for clarity, can be combined if wanted
  actions_minus_tabs = replace(chomp(var.action_list), "\t", "")
  actions_minus_cr   = replace(local.actions_minus_tabs, "\r", "")
  actions_array      = split("\n", local.actions_minus_cr)
  actions_clean_array = [
    for s in local.actions_array :
    trimspace(s)
  ]
}

resource "ibm_iam_custom_role" "custom" {
  name         = var.role_name
  display_name = coalesce(var.role_display_name, var.role_name)
  service      = var.service_name
  actions      = local.actions_clean_array
}
