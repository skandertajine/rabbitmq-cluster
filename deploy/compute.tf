//Rabbitmq instance group for internal load balancer
resource  "google_compute_instance_group" "default" {
    name                  = "rabbitmq-instance-group"
    project               = "${var.project}"
    zone                  = "${var.zone}"
    instances             = [
      "${google_compute_instance.noeud.0.self_link}",
      "${google_compute_instance.noeud.1.self_link}",
      "${google_compute_instance.noeud.2.self_link}",
       ] 
}
//Instance schema
resource "google_compute_instance" "noeud" {
  project                 = "${var.project}"
  count                   = "${var.count}"
  name                    = "rabbitmq-${count.index}"
  machine_type            = "${var.vm_type}" // May have to change 
  zone                    = "${var.zone}"
  tags                    = ["${var.target_tags}"]
  metadata_startup_script = "${file("startup_script.bash")}"
  scheduling {// ask yann about it 
    automatic_restart   = false
    on_host_maintenance = "MIGRATE"
  } 
  boot_disk { 
        initialize_params {
          image           = "rabbitmq-${var.image_version}"  //Packerized
          size            = 10         
          type            = "${var.disk_type}"
          }
        auto_delete       = true // talk about this with Thomas      
        }
  network_interface {
    network               = "default"
     access_config {}
    }
 
 
 

   
















}

