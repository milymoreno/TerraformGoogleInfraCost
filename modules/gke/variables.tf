variable "region" {
  type        = string
  description = "Región donde se desplegará el clúster GKE"
}

variable "network" {
  type        = string
  description = "Nombre de la red VPC"
}

variable "subnetwork" {
  type        = string
  description = "Nombre de la subred donde se ubicará el clúster"
}
