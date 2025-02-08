module "aws_cognito_user_pool" {
  source = "lgallard/cognito-user-pool/aws"

  user_pool_name             = local.user_pool_name
  alias_attributes           = var.alias_attributes
  auto_verified_attributes   = var.auto_verified_attributes
  sms_authentication_message = var.sms_authentication_msg
  sms_verification_message   = var.sms_verification_msg

  admin_create_user_config = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Here, your verification code baby"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }

  device_configuration = {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  user_pool_add_ons = {
    advanced_security_mode = var.advanced_security_mode
  }

  verification_message_template = {
    default_email_option = var.default_email_option
  }

  domain = var.user_pool_domain

  clients = [
    {
      name                                 = var.user_poll_app_client_name
      allowed_oauth_flows                  = ["code"]
      allowed_oauth_flows_user_pool_client = false
      allowed_oauth_scopes                 = ["email", "openid", "profile", "aws.cognito.signin.user.admin"]
      callback_urls                        = ["https://${var.website_root_domain}"]
      logout_urls                          = ["https://${var.website_root_domain}"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      read_attributes                      = var.user_poll_app_client_read_attributes
      supported_identity_providers         = ["COGNITO"]
      write_attributes                     = []
      access_token_validity                = 5
      id_token_validity                    = 5
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "minutes"
        id_token      = "minutes"
        refresh_token = "days"
      }
    }
  ]
}
