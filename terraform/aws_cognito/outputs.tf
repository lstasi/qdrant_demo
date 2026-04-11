output "cognito_user_pool_id" {
  value = "export COGNITO_USER_POOL_ID=${aws_cognito_user_pool.user_pool.id}"
}
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}
output "token_signing_key" {
  value = "export JWK_URL=https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.user_pool.id}/.well-known/jwks.json"
}
output "cognito_login_url" {
  value = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${var.aws_region}.amazoncognito.com/login?response_type=token&client_id=${aws_cognito_user_pool_client.user_pool_client.id}&response_type=token&scope=email+openid+profile&redirect_uri=http://localhost:8000/auth/callback"
}