variable "domain_name" {
  type        = string
  description = "The domain name to use"
  default     = "examensoluciondesignpatterns.click"
}

variable "eks_cluster_name" {
  type        = string
  description = "A timeout for the aws_route_table creation, default is 5m"
  default     = "ue2deveksdesignpatterns01"
}

variable "create_timeout" {
  type        = string
  default     = "10m"
  description = "A timeout for the aws_route_table creation, default is 5m"
}

variable "delete_timeout" {
  type        = string
  default     = "10m"
  description = "A timeout for the aws_route_table creation, default is 5m"
}

variable "default_security_group_id" {
  type        = string
  default     = "sg-02507282f0acf407d"
  description = "A timeout for the aws_route_table creation, default is 5m"
}

variable "access_key" {
    description = "Access key to AWS console"
}

variable "secret_key" {
    description = "Secret key to AWS console"
}

variable "region" {
    description = "AWS region"
}

