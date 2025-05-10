resource "google_firestore_database" "default" {
  name        = "(default)"
  project     = var.project_id
  location_id = "nam5" # puedes usar "us-central" si prefieres
  type        = "NATIVE"
}
