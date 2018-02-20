variable zone {
   description = "La Zone du groupe d instances managees ."
   default     = "europe-west1-c"
}
variable name {
   description = "La Zone du groupe d instances managees ."
   default     = "rabbitmq"
}
variable image_version {
  description = "Version de l image Packerisee"
  default     = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-9-stretch-v20180206"
}
variable count {
  description = "Nombre d instances à lancer"
  default = 3
}
variable vm_type {
  description = "Taille des instances"
  default = "n1-standard-1"
}
variable region {
  description = "La region des ressources Cloud ."
  default     = "europe-west1"
}
variable network {
  description = "Nom du reseau sur le quel est lancee l infrastructure"
  default = "default"
}
variable project {
  description = "Nom du projet sur le quel est lancee l infrastructure"
  default = "skale-5"
}
variable disk_type {
  description = "type du disque utilise pour la VM "
  default = "pd-ssd"
}
variable target_tags {
  description = "List of target tags to allow traffic using firewall rule."
  type        = "list"
  default     =["skander"]
}
variable service_port {
  description = "Port the service is listening on."
  default     = 5672
}
variable management_port {
  description = "Port de la page de management de rabbitmq"
  default     = 15672
}
variable firewall_project {
  description = "Name of the project to create the firewall rule in. Useful for shared VPC. Default is var.project."
  default     = "skale-5"
}
variable session_affinity {
  description = "How to distribute load. Options are `NONE`, `CLIENT_IP` and `CLIENT_IP_PROTO`"
  default     = "NONE"
}


