terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

variable "k8s_cluster" {
  type = map(string)
}

provider helm {
  kubernetes {
    host                   = lookup(var.k8s_cluster, "host")
    client_certificate     = lookup(var.k8s_cluster, "client_certificate")
    client_key             = lookup(var.k8s_cluster, "client_key")
    cluster_ca_certificate = lookup(var.k8s_cluster, "cluster_ca_certificate")
  }
}

resource helm_release test {
  name  = "test"
  chart = "${path.module}/local-charts/test-chart"
}

resource helm_release multi {
  count = 10

  name  = "multi-${count.index}"
  chart = "${path.module}/local-charts/test-chart"
}

resource helm_release nginx_ingress {
  name       = "nginx-ingress-controller"
  chart      = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource helm_release redis {
  name       = "redis"
  chart      = "redis"
  repository = "https://charts.bitnami.com/bitnami"
}

resource helm_release redis2 {
  name       = "redis2"
  chart      = "redis"
  repository = "https://charts.bitnami.com/bitnami"
}


resource helm_release postgresql {
  name       = "postgresql"
  chart      = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"

  timeout    = 800
}
