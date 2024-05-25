output "id" {
  value = aws_cognito_user_pool.user_pool.id
}
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}
output "domain" {
  value = aws_cognito_user_pool_domain.main.domain
}
output "callback_urls" {
  value = ["http://${local.hostname}/auth/callback","http://localhost:8000/auth/callback"]
}
output "load_balancer_hostname" {
  value = local.hostname
}