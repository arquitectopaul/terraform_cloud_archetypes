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
  default     = "Patrones-Desarrollo-e-Integracion"
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
    business_unit    = "banbif"
    cost_center_id   = "900700"
    cost_center_name = "raul_diaz"
    cost_center_tech = "miguel_casique"
    managed_by       = "TI-EA2022-12568"
  }
}

# Codigos personalizados de tipos de recursos

variable "custom_ec2_instance_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Instance del servicio AWS EC2"
  default     = "ec2"
}

variable "custom_key_pair_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Key Pair del servicio AWS EC2"
  default     = "kp"
}

variable "custom_security_group_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Security Group del servicio AWS EC2"
  default     = "sg"
}

variable "custom_policy_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Policy del servicio AWS IAM"
  default     = "policy"
}

variable "custom_eks_cluster_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Cluster EKS del servicio AWS EKS"
  default     = "eks"
}

variable "custom_fargate_profile_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Profile del servicio AWS Fargate"
  default     = "fargatepf"
}

# Configuracion de recursos a aprovisionar
variable "bastion_instance_ami" {
  type        = string
  description = ""
  default     = "ami-009c5f630e96948cb"
}

variable "kubernetes_namespace" {
  type        = string
  description = ""
  default     = "backend"
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
