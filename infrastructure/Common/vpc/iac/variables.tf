# required for AWS
variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "us-east-1"
}

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
  description = "Nombre compacto del proyecto"
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
variable "existing_transit_gateway_id" {
  type        = string
  description = "ID del Transit Gateway al cual se atachara la VPC que se aprovisionará. Se coloca a mano."
  default     = "tgw-02eee85bbed540b38"
}

# Codigos personalizados de tipos de recursos
variable "custom_vpc_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso VPC"
  default     = "vpc"
}

variable "custom_transit_gateway_attachment_resource_code" {
  type        = string
  description = "Codigo personalizado del tipo de recurso Transit Gateway Attachment"
  default     = "tgwatt"
}

# Configuracion de recursos a aprovisionar
variable "availability_zones_quantity" {
  type        = number
  description = "Cantidad de zonas de disponibilidad a aprovisionar"
  default     = 2
}

variable "vpc_cidr" {
  type        = string
  description = "El CIDR que determinara la cantidad de IPs disponibles para la VPC a aprovisionar"
  default     = "172.17.0.0/16"
}

# TODO: Por que es necesario "network aws root account route"
variable "remote_private_routes" {
  type = map(object({
    cidr_blocks = string
  }))
  description = "Private route list"
  default = {
    "network aws root account route" = {
      cidr_blocks = "172.16.0.0/16",
    }
    "onpremise server route" = {
      cidr_blocks = "10.0.0.0/8",
    }
  }
}
