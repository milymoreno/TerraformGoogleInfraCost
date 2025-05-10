resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}

resource "google_storage_bucket" "function_bucket" {
  name     = "${var.project_id}-function-bucket"
  location = var.region
  force_destroy = true
}

resource "google_storage_bucket_object" "function_archive" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "${path.module}/function-source/function-source.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "pubsub-listener"
  description = "Cloud Function triggered by Pub/Sub"
  runtime     = var.runtime
  region      = var.region
  project     = var.project_id
  entry_point = var.entry_point

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.topic.id
  }
}

# resource "google_pubsub_topic_iam_member" "publisher" {
#   topic = google_pubsub_topic.topic.name
#   role  = "roles/pubsub.publisher"
#   member = "serviceAccount:${google_cloudfunctions_function.function.service_account_email}"
# }

# resource "google_pubsub_subscription" "subscription" {
#   name  = "${var.topic_name}-subscription"
#   topic = google_pubsub_topic.topic.name

#   ack_deadline_seconds = 10
#   retention_duration   = "604800s"
# }
# resource "google_pubsub_subscription_iam_member" "subscriber" {
#   subscription = google_pubsub_subscription.subscription.name
#   role         = "roles/pubsub.subscriber"
#   member       = "serviceAccount:${google_cloudfunctions_function.function.service_account_email}"
# }
# resource "google_pubsub_topic_iam_member" "publisher" {
#   topic = google_pubsub_topic.topic.name
#   role  = "roles/pubsub.publisher"
#   member = "serviceAccount:${google_cloudfunctions_function.function.service_account_email}"
# }