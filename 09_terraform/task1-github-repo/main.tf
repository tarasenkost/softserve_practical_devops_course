terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }
}
provider "github" {
  # token = var.github_token
  token = "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"
  owner = "Practical-DevOps-GitHub"
}
resource "github_repository" "task_repository" {
  name       = "github-terraform-task-fieryybird"
  visibility = "public"
}
resource "github_branch" "develop" {
  repository    = github_repository.task_repository.name
  branch        = "develop"
  source_branch = "main"
}
resource "github_branch_default" "default_branch" {
  repository = github_repository.task_repository.name
  branch     = "develop"
  depends_on = [github_branch.develop]
}
resource "github_repository_collaborator" "softservedata" {
  repository = github_repository.task_repository.name
  username   = "softservedata"
  permission = "admin"
}
resource "github_branch_protection" "main" {
  repository_id = github_repository.task_repository.id
  pattern       = "main"
  required_pull_request_reviews {
    require_code_owner_reviews = true
    required_approving_review_count = 0
  }
}
resource "github_branch_protection" "develop" {
  repository_id = github_repository.task_repository.id
  pattern       = "develop"
  required_pull_request_reviews {
    required_approving_review_count = 2
  }
}
resource "github_repository_file" "codeowners" {
  repository     = github_repository.task_repository.name
  file           = ".github/CODEOWNERS"
  content        = "* @softservedata"
  commit_message = "add CODEOWNERS file"
  branch         = "main"
}
resource "github_repository_deploy_key" "deploy_key" {
  repository = github_repository.task_repository.name
  title      = "DEPLOY_KEY"
  key        = var.deploy_key_public
  read_only  = false
}
resource "github_actions_secret" "pat" {
  repository      = github_repository.task_repository.name
  secret_name     = "PAT"
  plaintext_value = var.github_token
}
resource "github_repository_webhook" "discord_webhook" {
  repository = github_repository.task_repository.name
  configuration {
    url          = "https://discordapp.com/api/webhooks/1286301011207655464/QUMgYs1UMsoA0NOSdBb8DwK4FjVqU3dsK8eHmnrnE67B70gJUekSl1LzUDwLhoY-zb-7"
    content_type = "json"
  }
  events = ["pull_request"]
}
variable "github_token" {
  type    = string
  default = "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"
}
variable "deploy_key_public" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZdMnpQ+5iR4lptHBpy0jO2DxVXEYYJ3lFkZUVn0Rbc fieryybird@g14"
}

