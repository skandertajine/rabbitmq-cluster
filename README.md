# Rabbitmq Cluster w/ Terraform & Ansible

Rabbitmq is a message broker, used to share messages throughout the network.

By now this role installs a pre-configured cluster of rabbitmq's instances on GCP with a default user and the administration plugin.

The goal behind this repository is to create the bellow described architecture of a highly available rabbitmq cluster.
Terraform creates the infrastructure on GCP and Ansible , locally ,configures the nodes by pulling this repository.

## Architecture
![alt text](https://github.com/skandertajine/rabbitmq-cluster/blob/master/images/archi.png)
## Data persistancy 

The node's exchange data is mirrored and real-time synchronized between the nodes so that in case of interruption (desired or not) of one or multiple nodes , it ( the data ) is always(SLA xx,xxx%) safely persisted in the remaning alive nodes.


## Getting Started
## Configuration
### Infrastructure configuration
File Location : /deploy/terraform.tfvars

Change these values to customise your infrastructure.
```tfvars
zone  = "europe-west1-c"
count = 3 #This count has to be the same as the cluster nodes configuration below ( File Location : /bake/localhost.yaml)
vm_type = "n1-standard-1"
variable region = "europe-west1" 
network = "default"
project  = "skale-5"
target_tags=["skander"]
firewall_project= "skale-5"
```

### Node configuration
File Location : /bake/localhost.yaml
```yaml
rabbitmq_user           : "@changeme@"
rabbitmq_password       : "@changeme@"
cookie                  : "@changeme@" #see 'Cluster Security and authentication management' for further information about clustering

rabbitmq_nodename       : "rabbitmq"
rabbitmq_ip_adress      : "{{ ansible_eth0.ipv4.address }}"
rabbitmq_node_port      : 5672
item                    : "rabbitmq-server"

rabbitmq_cluster_nodes  : ['rabbit@{{ rabbitmq_nodename }}-0'] #see 'Cluster configuration schema' for further information about clustering
```
  ### Cluster Security and authentification management
  File Location : /bake/localhost.yaml
  The cluster nodes uses a cookie string to ensure authentification to each other.
  The cookie will be typically located in ```/var/lib/rabbitmq/.erlang.cookie``` and it must be identical within all nodes.
  
 
  ### Cluster configuration 
  File Location : /bake/localhost.yaml
 You can choose the number of clustered rabbitmq's nodes by changing the parameter below :
#### Skeleton :
The parameter's configuration skeleton is :
```yaml
rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               ]" 
 ```   
#### Examples : 
 
- 3 Rabbitmq Nodes in cluster : 
 ```yaml     
rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-0' ,
                               'rabbit@{{ rabbitmq_nodename }}-1' ,
                               'rabbit@{{ rabbitmq_nodename }}-2'
                               ]"                                                                                                                                                    
```
- 2 Rabbitmq Nodes in cluster : 
```yaml
rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-0' ,
                               'rabbit@{{ rabbitmq_nodename }}-1' ,
                               ]" 
 ```
 
                             
### What you need to know :
```
'rabbit@' is required by the rabbitmq clustering controller.
Simple quotes also is required.
Jinja adds a "u" symbol when double quotes " " cercling the [array] are missing. 
 ```
## Benchmarks

Theese benchmarks can help you to choose the correction configuration depending on your needs.
Real time performances may differ depending on your situation (message size , nombre of consumers/producers..).
In our case , in order to get ceiling results , tests have been made using one producer communicating with one consumer.
![alt text](https://github.com/skandertajine/rabbitmq-cluster/blob/master/images/benchmark.png)

## Deployment.
To do so we use Terraform to deploy the architecture.
Use terraform plan and terraform apply in the Deploy directory in order to deploy the pre-configured infrastructure.
## Monitoring
Rabbitmq's management plugin is already installed accesible locally via the loadbalancing IP:15672.
It will require credentials to login , use "rabbitmq_user" and "rabbitmq_password" precedently configured.

![alt text](https://github.com/skandertajine/rabbitmq-cluster/blob/master/images/managementpluging.png)
## Troubleshooting
```
* Sometimes Rabbitmq(service rabbitmq-server ) doesn't want to start , it maybe sometimes caused by a wrong character in the cookie file.
* Rabbitmq binds it's configuration with the current context (hostname, IP etc..) , if one of theese come to change the node can be instable and configuration may disappear.
* rabbitmqctl reset deletes the configuration of the node(policies,users etc..)
