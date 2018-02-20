# Rabbitmq Cluster w/ Terraform & Ansible

Rabbitmq is a message broker, used to share messages throughout the network.

By now this role installs a pre-configured cluster of rabbitmq's instances on GCP with a default user and the administration plugin.

## Architecture
![alt text](https://github.com/skandertajine/rabbitmq-cluster/bake/images/blob/master/architecture.png)
## Data persistancy 

The node's exchange data is mirrored and real-time synchronized between the nodes so that in case of interruption (desired or not) of one or multiple nodes , it ( the data ) is always(SLA xx,xxx%) safly persisted in the remaning alive node.


## Getting Started
## Configuration
### Main configuration
```yaml
rabbitmq_user           : "@changeme@"
rabbitmq_password       : "@changeme@"
cookie                  : "@changeme@" #see 'Cluster Security and authentification management' for further information about clustering

rabbitmq_nodename       : "rabbitmq"
rabbitmq_ip_adress      : "{{ ansible_eth0.ipv4.address }}"
rabbitmq_node_port      : 5672
item                    : "rabbitmq-server"

rabbitmq_cluster_nodes  : ['rabbit@{{ rabbitmq_nodename }}-0'] #see 'Cluster configuration schema' for further information about clustering
```
  ### Cluster Security and authentification management
  
  The cluster nodes uses a cookie string to ensure authentification between each other.
  The cookie will be typically located in ```/var/lib/rabbitmq/.erlang.cookie``` and it must be identical within all nodes.
  
 
  ### Cluster configuration schema
 
 You can choose the number of clustered rabbitmq's nodes by changing the parameter below :
#### Schema :
The parameter's configuration schema is :
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
End with an example of getting some data out of the system or using it for a little demo
 ```
## Running the tests
## Deployment.
To do so we use Terraform to deploy the architecture.
Use terraform plan and terraform apply in the Deploy directory in order to deploy the pre-configured infrastructure.
## Monitoring
Rabbitmq's management plugin is already installed accesible locally via the loadbalancing IP:15672.
It will require credentials to login , use "rabbitmq_user" and "rabbitmq_password" precedently configured.

![alt text](https://github.com/skandertajine/rabbitmq-cluster/bake/images/blob/master/managementpluging.png)
## Troubleshooting
Sometimes Rabbitmq(service rabbitmq-server ) doesn't want to start , it maybe sometimes caused by a wrong character in the cookie file.
