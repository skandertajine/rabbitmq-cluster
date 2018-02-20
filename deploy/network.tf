//Static IP address for the external load balancer
resource "google_compute_address" "rabbitmq-service" {
  name                  = "rabbitmq-service"
  project               = "${var.project}" 
  region               = "${var.region}" 
}
//Internal load balancer front end
resource "google_compute_forwarding_rule" "service-front" {
  project               = "${var.project}"
  name                  = "${var.name}internal"
  region                = "${var.region}"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["${var.service_port}"]
  backend_service       = "${google_compute_region_backend_service.rabbit_pool.self_link}"
}
//External load balancer front end
resource "google_compute_forwarding_rule" "management-front" {
  project               = "${var.project}"
  name                  = "${var.name}external"
  region                = "${var.region}"
  target                = "${google_compute_target_pool.default.self_link}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "${var.management_port}"
  ip_address            = "${google_compute_address.rabbitmq-service.address}"
}
//Internal load balancer backend
resource "google_compute_region_backend_service" "rabbit_pool" {
  name        = "rabbitmq-internal-lb"
  project     ="${var.project}" 
  region      = "${var.region}"
  protocol    = "TCP"
  timeout_sec = 10
  backend {
    group = "${google_compute_instance_group.default.self_link}"
  }

  health_checks = ["${google_compute_health_check.default.self_link}"]
}
//External load balancer back end
resource "google_compute_target_pool" "default" {
  project          = "${var.project}"
  name             = "rabbitmq-external-lb"
  region           = "${var.region}"

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
  instances = [
    "${google_compute_instance.noeud.0.self_link}",
    "${google_compute_instance.noeud.1.self_link}",
     "${google_compute_instance.noeud.2.self_link}",
  ]
}
//Management page and load balancer health check on HTTP:15672
resource "google_compute_http_health_check" "default" {
  project      = "${var.project}"
  name = "external-service-health-check"
  request_path = "/"
  port         = "${var.management_port}"
}
//Rabbitmq service health check on TCP:5672
resource "google_compute_health_check" "default" {
  name = "internal-service-health-check"
  project      = "${var.project}"
  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "${var.service_port}"
  }
}
//Firewalling rules
resource "google_compute_firewall" "default-lb-fw" {
  project = "${var.firewall_project == "" ? var.project : var.firewall_project}"
  name    = "${var.name}-vm-service"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["${var.management_port}"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.target_tags}"]
}