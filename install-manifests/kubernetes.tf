terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "k8s_cluster" {
  type = map(string)
}

provider kubernetes {
  host                   = lookup(var.k8s_cluster, "host")
  client_certificate     = lookup(var.k8s_cluster, "client_certificate")
  client_key             = lookup(var.k8s_cluster, "client_key")
  cluster_ca_certificate = lookup(var.k8s_cluster, "cluster_ca_certificate")
}

resource kubernetes_config_map test {
  metadata {
    name = "test"
  }

  data = {
    TEST = "test"
  }
}

resource kubernetes_deployment "test" {
  metadata {
    name = "test"
  }
  spec {
   selector {
     match_labels = {
       app = "test"
     }
   }
    template {
      metadata {
        name = "test"
        
        labels = {
          app = "test"
        }
      }
      spec {
        container {
          image   = "busybox:1.32.0"
          name    = "test"
          command = [
            "sleep",
            "infinity"
          ]
        }
      }
    }
  }
}

resource kubernetes_job "test" {
  metadata {
    name = "test"
  }
  spec {
    template {
      metadata {
        name = "test"
      }
      spec {
        automount_service_account_token = false

        container {
          image   = "busybox:1.32.0"
          name    = "test"
          command = [
            "sleep",
            "60"
          ]
        }
      }
    }
  }
}

resource kubernetes_pod "test" {
  metadata {
    name = "test"
  }
  spec {
    automount_service_account_token = false

    container {
      image   = "busybox:1.32.0"
      name    = "test"
      command = [
        "sleep",
        "infinity"
      ]
    }
  }
}