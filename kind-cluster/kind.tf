terraform {
  required_providers {
    kind = {
      source = "kyma-incubator/kind"
    }
  }
}

variable "kube_config_path" {
  default = "~/.kube/config"
}

data "local_file" "kubeconfig" {
  filename = pathexpand(var.kube_config_path)
}

resource "kind_cluster" "test" {
  name = "terraform-test-cluster"
}

output "k8s_cluster" {
  value = {
    host                   = kind_cluster.test.endpoint
    cluster_ca_certificate = kind_cluster.test.cluster_ca_certificate
    client_certificate     = kind_cluster.test.client_certificate 
    client_key             = kind_cluster.test.client_key
  }
}