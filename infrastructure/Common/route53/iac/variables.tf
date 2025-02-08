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

# Configuracion de recursos a aprovisionar
variable "domain_name" {
  description = "Name of the domain."
  default     = "examensolucion.com"
}

variable "acm_validation_method" {
  default = "DNS"
}

variable "acm_ttl" {
  default = 60
}

variable "create_timeout" {
  type        = string
  default     = "10m"
  description = "A timeout for the aws_route_table creation, default is 5m"
}
