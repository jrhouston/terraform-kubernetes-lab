module cluster {
  source = "./kind-cluster"
}

module charts {
  source = "./install-charts"
  k8s_cluster = module.cluster.k8s_cluster
}

module manifests {
  source = "./install-manifests"
  k8s_cluster = module.cluster.k8s_cluster
}