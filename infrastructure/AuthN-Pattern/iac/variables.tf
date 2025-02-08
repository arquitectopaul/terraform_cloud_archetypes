# Informacion del proyecto
variable "custom_region_code" {
  type        = string
  description = "Codigo personalizado de region AWS (Ejm.: us-east-1=ue1, us-west-1=uw1)"
  default     = "ue1"
}

variable "environment_code" {
  type        = string
  description = "Codigo del ambiente (Ejm.: Desarrollo=dev, Calidad=qa, Produccion=prod)"
  default     = "dev"
}

variable "compacted_project_name" {
  type        = string
  description = "Nombre compacto del proyecto. Todos en minusculas y sin espacios."
  default     = "examensolucion"
}

variable "extended_project_name" {
  type        = string
  description = "Nombre amplio del proyecto. No debe tener espacios y debe estar separado las palabras por guiones."
  default     = "Patrones_Microservicios"
}

variable "serial_number" {
  type        = string
  description = "Numero correlativo del proyecto"
  default     = "01"
}

variable "info_tags" {
  type        = map(string)
  description = "Etiquetas con informacion general asociada al proyecto"
  default = {
    business_unit    = "acme"
    cost_center_id   = "0"
    cost_center_name = "pepito"
    cost_center_tech = "juanperez"
    managed_by       = "TERRAFORM"
  }
}

# Referencias a recursos existentes requeridos
variable "website_root_domain" {
  description = "Hostname for this website."
  default     = "examensolucion.com"
}

# Codigos personalizados de tipos de recursos
variable "custom_bucket_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Bucket del servicio AWS S3"
  default     = "bucket"
}

variable "custom_distribution_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Distribution del servicio AWS CloudFront"
  default     = "dist"
}

variable "custom_origin_access_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Origin Access del servicio AWS CloudFront"
  default     = "oa"
}

variable "custom_cognito_user_pool_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso User Pool del servicio Amazon Cognito"
  default     = "userpool"
}

variable "custom_web_acl_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Web ACL del servicio AWS WAF"
  default     = "webacl"
}

variable "custom_web_acl_metric_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Web ACL Metric del servicio AWS WAF"
  default     = "waclm"
}

variable "custom_waf_rule_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Rule del servicio AWS WAF"
  default     = "wafrule"
}

variable "custom_waf_rule_metric_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Rule Metric del servicio AWS WAF"
  default     = "wrulem"
}

variable "custom_waf_rule_group_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso ### del servicio ###"
  default     = "wruleg"
}

# Configuracion de recursos a aprovisionar
variable "main_frontend_name" {
  default = "main"
}

variable "microfrontend_app_name_prefix" {
  default = "mf-"
}

variable "microfrontend_names" {
  type        = list(string)
  description = ""
  default     = ["login", "home", "accounts"]
}

variable "distribution_default_cache_ttl" {
  description = "Tiempo de cache en segundos."
  default     = 0
}

variable "wildcard_ssl" {
  description = "Wildcard SSL certificate domain name.  E.g. *.example.com"
  default     = ""
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "delete_timeout" {
  type        = string
  default     = "10m"
  description = "A timeout for the aws_route_table creation, default is 5m"
}

variable "user_pool_domain" {
  default = "arq-user-pool-mbenites"
}

variable "user_poll_app_client_name" {
  default = "web-app-client"
}

variable "alias_attributes" {
  default = ["email", "phone_number"]
}

variable "auto_verified_attributes" {
  default = ["email"]
}

variable "advanced_security_mode" {
  default = "ENFORCED"
}

variable "default_email_option" {
  default = "CONFIRM_WITH_CODE"
}

variable "user_poll_app_client_read_attributes" {
  default = ["address", "birthdate", "email", "email_verified", "family_name", "gender",
    "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "phone_number_verified",
  "picture", "preferred_username", "profile", "updated_at", "website", "zoneinfo"]
}

variable "sms_authentication_msg" {
  default = "Your username is {username} and temporary password is {####}."
}

variable "sms_verification_msg" {
  default = "This is the verification message {####}."
}

variable "waf_ipset_name" {
  default = "ipsetdescriptor_login"
}

variable "waf_ip_set_descriptors_type" {
  default = "IPV4"
}

variable "waf_ip_set_descriptors_value" {
  default = "10.113.0.0/20"
}

variable "waf_predicates_type" {
  default = "IPMatch"
}

variable "waf_predicates_negated" {
  default = false
}

variable "waf_activated_rule_action" {
  default = "COUNT"
}

variable "waf_activated_rule_priority" {
  default = 50
}

variable "waf_default_action_type" {
  default = "ALLOW"
}

variable "waf_rules_action_type" {
  default = "BLOCK"
}

variable "waf_rules_priority" {
  default = 1
}

variable "waf_rules_type" {
  default = "REGULAR"
}
