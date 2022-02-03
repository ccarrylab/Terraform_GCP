provider "google" {
  project     = "orbital-ability-340123"
 # project = "postgresql-276510"
  region      = "us-east4"
}
resource "google_dataproc_cluster" "cluster1" {
  name     = "dataproc-singlenode"
  region      = "us-east4"
  labels = {
    cluster = "one-in-one"
  }

  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-1"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 15
      }
    }
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }
    gce_cluster_config {
      tags = [ "cluster", "one-in-one" ]
      service_account_scopes = [
        "https://www.googleapis.com/auth/monitoring",
        "useraccounts-ro",
        "storage-rw",
        "logging-write",
      ]
    }
  }
}
