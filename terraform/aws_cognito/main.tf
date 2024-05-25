data "kubernetes_service" "istio-ingressgateway" {
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }
}
locals {
  hostname = data.kubernetes_service.istio-ingressgateway.status[0].load_balancer[0].ingress[0].hostname
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.name}-user-pool"

  username_attributes = ["email"]

  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "${var.name}-user-pool-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  supported_identity_providers = ["COGNITO"]

  callback_urls = ["http://localhost:8000/auth/callback", "https://${local.hostname}/auth/callback"]
  logout_urls   = ["http://localhost:8000/auth/logout", "https://${local.hostname}/auth/logout"]

  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true
}

