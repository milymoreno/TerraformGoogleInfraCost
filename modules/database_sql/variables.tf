variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "db_instance_name" {
  type = string
  description = "Nombre de la instancia de Cloud SQL"
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
  description = "Nombre de la base de datos a crear dentro de la instancia"
}
