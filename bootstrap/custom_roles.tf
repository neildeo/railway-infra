resource "google_project_iam_custom_role" "terraform_plan" {
  role_id     = "TerraformPlan"
  title       = "Terraform Plan"
  description = "Read-only permissions required by terraform-ci to refresh Terraform state and generate plans."

  permissions = [
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",

    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.getIamPolicy",

    "iam.roles.get",
    "iam.roles.list",

    "storage.buckets.get",
    "storage.buckets.getIamPolicy",

    "iam.workloadIdentityPools.get",
    "iam.workloadIdentityPools.getAttestationRules",
    "iam.workloadIdentityPools.list",
    "iam.workloadIdentityPoolProviders.get",
    "iam.workloadIdentityPoolProviders.list",
  ]

  project = local.project_id
}


resource "google_project_iam_custom_role" "terraform_apply" {
  role_id     = "TerraformApply"
  title       = "Terraform Apply"
  description = "Project-level permissions temporarily granted to terraform-ci for Terraform apply operations."

  permissions = [
    "storage.buckets.create",
  ]

  project = local.project_id
}