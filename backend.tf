resource "google_project" "cloudresumechallenge_406720" {
  auto_create_network = true
  billing_account     = "015498-350D91-2476D2"
  name                = "cloudresumechallenge"
  project_id          = "cloudresumechallenge-406720"
}
# terraform import google_project.cloudresumechallenge_406720 projects/cloudresumechallenge-406720
resource "google_compute_address" "external_ip_resume" {
  address      = "35.209.69.100"
  address_type = "EXTERNAL"
  name         = "external-ip-resume"
  network_tier = "STANDARD"
  project      = "cloudresumechallenge-406720"
  region       = "us-central1"
}
# terraform import google_compute_address.external_ip_resume projects/cloudresumechallenge-406720/regions/us-central1/addresses/external-ip-resume
resource "google_artifact_registry_repository" "gcf_artifacts" {
  description = "This repository is created and used by Cloud Functions for storing function docker images."
  format      = "DOCKER"
  labels = {
    goog-managed-by = "cloudfunctions"
  }
  location      = "us-central1"
  project       = "cloudresumechallenge-406720"
  repository_id = "gcf-artifacts"
}
# terraform import google_artifact_registry_repository.gcf_artifacts projects/cloudresumechallenge-406720/locations/us-central1/repositories/gcf-artifacts
resource "google_compute_firewall" "default_allow_ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  description   = "Allow SSH from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-ssh"
  network       = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/networks/default"
  priority      = 65534
  project       = "cloudresumechallenge-406720"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_ssh projects/cloudresumechallenge-406720/global/firewalls/default-allow-ssh
resource "google_compute_firewall" "default_allow_icmp" {
  allow {
    protocol = "icmp"
  }
  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/networks/default"
  priority      = 65534
  project       = "cloudresumechallenge-406720"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_icmp projects/cloudresumechallenge-406720/global/firewalls/default-allow-icmp
resource "google_compute_firewall" "default_allow_rdp" {
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }
  description   = "Allow RDP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-rdp"
  network       = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/networks/default"
  priority      = 65534
  project       = "cloudresumechallenge-406720"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_rdp projects/cloudresumechallenge-406720/global/firewalls/default-allow-rdp
resource "google_compute_backend_bucket" "gcp_backend_bucket" {
  bucket_name = "gcp-cloudresume"
  cdn_policy {
    cache_mode         = "CACHE_ALL_STATIC"
    client_ttl         = 3600
    default_ttl        = 3600
    max_ttl            = 86400
    request_coalescing = true
  }
  enable_cdn = true
  name       = "gcp-backend-bucket"
  project    = "cloudresumechallenge-406720"
}
# terraform import google_compute_backend_bucket.gcp_backend_bucket projects/cloudresumechallenge-406720/global/backendBuckets/gcp-backend-bucket
resource "google_compute_global_forwarding_rule" "http_1b_forwarding_rule" {
  ip_address            = "34.160.95.235"
  ip_protocol           = "TCP"
  ip_version            = "IPV4"
  load_balancing_scheme = "EXTERNAL"
  name                  = "http-1b-forwarding-rule"
  port_range            = "80-80"
  project               = "cloudresumechallenge-406720"
  target                = "https://www.googleapis.com/compute/beta/projects/cloudresumechallenge-406720/global/targetHttpProxies/http-1b-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.http_1b_forwarding_rule projects/cloudresumechallenge-406720/global/forwardingRules/http-1b-forwarding-rule
resource "google_compute_firewall" "default_allow_internal" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  description   = "Allow internal traffic on the default network"
  direction     = "INGRESS"
  name          = "default-allow-internal"
  network       = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/networks/default"
  priority      = 65534
  project       = "cloudresumechallenge-406720"
  source_ranges = ["10.128.0.0/9"]
}
# terraform import google_compute_firewall.default_allow_internal projects/cloudresumechallenge-406720/global/firewalls/default-allow-internal
resource "google_service_account" "245461289076_compute" {
  account_id   = "245461289076-compute"
  display_name = "Compute Engine default service account"
  project      = "cloudresumechallenge-406720"
}
# terraform import google_service_account.245461289076_compute projects/cloudresumechallenge-406720/serviceAccounts/245461289076-compute@cloudresumechallenge-406720.iam.gserviceaccount.com
resource "google_service_account" "cloudresumechallenge_406720" {
  account_id   = "cloudresumechallenge-406720"
  display_name = "App Engine default service account"
  project      = "cloudresumechallenge-406720"
}
# terraform import google_service_account.cloudresumechallenge_406720 projects/cloudresumechallenge-406720/serviceAccounts/cloudresumechallenge-406720@cloudresumechallenge-406720.iam.gserviceaccount.com
resource "google_project_service" "bigquery_googleapis_com" {
  project = "245461289076"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 245461289076/bigquery.googleapis.com
resource "google_project_service" "artifactregistry_googleapis_com" {
  project = "245461289076"
  service = "artifactregistry.googleapis.com"
}
# terraform import google_project_service.artifactregistry_googleapis_com 245461289076/artifactregistry.googleapis.com
resource "google_project_service" "cloudbuild_googleapis_com" {
  project = "245461289076"
  service = "cloudbuild.googleapis.com"
}
# terraform import google_project_service.cloudbuild_googleapis_com 245461289076/cloudbuild.googleapis.com
resource "google_project_service" "datastore_googleapis_com" {
  project = "245461289076"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 245461289076/datastore.googleapis.com
resource "google_compute_url_map" "http_1b" {
  default_service = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/backendBuckets/gcp-backend-bucket"
  name            = "http-1b"
  project         = "cloudresumechallenge-406720"
}
# terraform import google_compute_url_map.http_1b projects/cloudresumechallenge-406720/global/urlMaps/http-1b
resource "google_compute_target_http_proxy" "http_1b_target_proxy" {
  name    = "http-1b-target-proxy"
  project = "cloudresumechallenge-406720"
  url_map = "https://www.googleapis.com/compute/v1/projects/cloudresumechallenge-406720/global/urlMaps/http-1b"
}
# terraform import google_compute_target_http_proxy.http_1b_target_proxy projects/cloudresumechallenge-406720/global/targetHttpProxies/http-1b-target-proxy
resource "google_project_service" "cloudfunctions_googleapis_com" {
  project = "245461289076"
  service = "cloudfunctions.googleapis.com"
}
# terraform import google_project_service.cloudfunctions_googleapis_com 245461289076/cloudfunctions.googleapis.com
resource "google_project_service" "containerregistry_googleapis_com" {
  project = "245461289076"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 245461289076/containerregistry.googleapis.com
resource "google_project_service" "logging_googleapis_com" {
  project = "245461289076"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 245461289076/logging.googleapis.com
resource "google_project_service" "serviceusage_googleapis_com" {
  project = "245461289076"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 245461289076/serviceusage.googleapis.com
resource "google_project_service" "cloudapis_googleapis_com" {
  project = "245461289076"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 245461289076/cloudapis.googleapis.com
resource "google_storage_bucket" "gcf_v2_uploads_245461289076_us_central1" {
  cors {
    method          = ["PUT"]
    origin          = ["https://*.cloud.google.com", "https://*.corp.google.com", "https://*.corp.google.com:*", "https://*.cloud.google", "https://*.byoid.goog"]
    response_header = ["content-type"]
  }
  force_destroy = false
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age        = 1
      with_state = "ANY"
    }
  }
  location                    = "US-CENTRAL1"
  name                        = "gcf-v2-uploads-245461289076-us-central1"
  project                     = "cloudresumechallenge-406720"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.gcf_v2_uploads_245461289076_us_central1 gcf-v2-uploads-245461289076-us-central1
resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "245461289076"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 245461289076/bigquerystorage.googleapis.com
resource "google_storage_bucket" "gcf_v2_sources_245461289076_us_central1" {
  cors {
    method = ["GET"]
    origin = ["https://*.cloud.google.com", "https://*.corp.google.com", "https://*.corp.google.com:*", "https://*.cloud.google", "https://*.byoid.goog"]
  }
  force_destroy = false
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 3
      with_state         = "ARCHIVED"
    }
  }
  location                    = "US-CENTRAL1"
  name                        = "gcf-v2-sources-245461289076-us-central1"
  project                     = "cloudresumechallenge-406720"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
# terraform import google_storage_bucket.gcf_v2_sources_245461289076_us_central1 gcf-v2-sources-245461289076-us-central1
resource "google_logging_log_sink" "a_required" {
  destination            = "logging.googleapis.com/projects/cloudresumechallenge-406720/locations/global/buckets/_Required"
  filter                 = "LOG_ID(\"cloudaudit.googleapis.com/activity\") OR LOG_ID(\"externalaudit.googleapis.com/activity\") OR LOG_ID(\"cloudaudit.googleapis.com/system_event\") OR LOG_ID(\"externalaudit.googleapis.com/system_event\") OR LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") OR LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Required"
  project                = "245461289076"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_required 245461289076###_Required
resource "google_project_service" "sql_component_googleapis_com" {
  project = "245461289076"
  service = "sql-component.googleapis.com"
}
# terraform import google_project_service.sql_component_googleapis_com 245461289076/sql-component.googleapis.com
resource "google_project_service" "storage_api_googleapis_com" {
  project = "245461289076"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 245461289076/storage-api.googleapis.com
resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "245461289076"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 245461289076/cloudtrace.googleapis.com
resource "google_project_service" "run_googleapis_com" {
  project = "245461289076"
  service = "run.googleapis.com"
}
# terraform import google_project_service.run_googleapis_com 245461289076/run.googleapis.com
resource "google_project_service" "pubsub_googleapis_com" {
  project = "245461289076"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 245461289076/pubsub.googleapis.com
resource "google_project_service" "bigquerymigration_googleapis_com" {
  project = "245461289076"
  service = "bigquerymigration.googleapis.com"
}
# terraform import google_project_service.bigquerymigration_googleapis_com 245461289076/bigquerymigration.googleapis.com
resource "google_project_service" "firestore_googleapis_com" {
  project = "245461289076"
  service = "firestore.googleapis.com"
}
# terraform import google_project_service.firestore_googleapis_com 245461289076/firestore.googleapis.com
resource "google_project_service" "compute_googleapis_com" {
  project = "245461289076"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 245461289076/compute.googleapis.com
resource "google_project_service" "monitoring_googleapis_com" {
  project = "245461289076"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 245461289076/monitoring.googleapis.com
resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "245461289076"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 245461289076/servicemanagement.googleapis.com
resource "google_logging_log_sink" "a_default" {
  destination            = "logging.googleapis.com/projects/cloudresumechallenge-406720/locations/global/buckets/_Default"
  filter                 = "NOT LOG_ID(\"cloudaudit.googleapis.com/activity\") AND NOT LOG_ID(\"externalaudit.googleapis.com/activity\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"externalaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") AND NOT LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Default"
  project                = "245461289076"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_default 245461289076###_Default
resource "google_project_service" "firebaserules_googleapis_com" {
  project = "245461289076"
  service = "firebaserules.googleapis.com"
}
# terraform import google_project_service.firebaserules_googleapis_com 245461289076/firebaserules.googleapis.com
resource "google_project_service" "oslogin_googleapis_com" {
  project = "245461289076"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 245461289076/oslogin.googleapis.com
resource "google_project_service" "eventarc_googleapis_com" {
  project = "245461289076"
  service = "eventarc.googleapis.com"
}
# terraform import google_project_service.eventarc_googleapis_com 245461289076/eventarc.googleapis.com
resource "google_project_service" "storage_component_googleapis_com" {
  project = "245461289076"
  service = "storage-component.googleapis.com"
}
# terraform import google_project_service.storage_component_googleapis_com 245461289076/storage-component.googleapis.com
resource "google_project_service" "storage_googleapis_com" {
  project = "245461289076"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 245461289076/storage.googleapis.com
resource "google_storage_bucket" "gcp_cloudresume" {
  force_destroy               = false
  location                    = "US-CENTRAL1"
  name                        = "gcp-cloudresume"
  project                     = "cloudresumechallenge-406720"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  website {
    main_page_suffix = "resume.html"
    not_found_page   = "error404.html"
  }
}
# terraform import google_storage_bucket.gcp_cloudresume gcp-cloudresume