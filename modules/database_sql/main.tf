resource "google_sql_database_instance" "postgres_instance" {
  name             = var.db_instance_name
  region           = var.region
  database_version = "POSTGRES_15"
  project          = var.project_id

  settings {
    tier = "db-f1-micro"  # puedes ajustar según necesidades
    ip_configuration {
      ipv4_enabled    = true
        #private_network = "projects/${var.project_id}/global/networks/default"  # Cambia esto si usas una VPC diferente
    }
    backup_configuration {
      enabled = true
    }
  }
}

resource "google_sql_user" "db_user" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
}
