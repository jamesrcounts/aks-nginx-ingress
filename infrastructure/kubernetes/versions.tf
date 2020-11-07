terraform {
  required_version = ">= 0.13"

  required_providers {
    # azuread = {
    #   source  = "hashicorp/azuread"
    #   version = "~> 1.0.0"
    # }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.32"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0"
    }
  }

  backend "remote" {
    organization = "jamesrcounts"

    workspaces {
      name = "aks-nginx-ingress-k8s"
    }
  }
}

provider azurerm {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = true
    }

    template_deployment {
      delete_nested_items_during_deletion = true
    }

    virtual_machine {
      delete_os_disk_on_deletion = true
    }

    virtual_machine_scale_set {
      roll_instances_when_required = true
    }
  }
}

locals {
  kube_config = data.azurerm_kubernetes_cluster.aks.kube_admin_config.0
}

provider "helm" {
  kubernetes {
    client_certificate     = base64decode(local.kube_config["client_certificate"])
    client_key             = base64decode(local.kube_config["client_key"])
    cluster_ca_certificate = base64decode(local.kube_config["cluster_ca_certificate"])
    host                   = local.kube_config["host"]
    load_config_file       = "false"
  }
}
