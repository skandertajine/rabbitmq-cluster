# Rabbitmq Cluster w/ Ansible + Terraform
# Configuration
  ## Cluster configuration schema
 
 You can choose the number of clustered rabbitmq's nodes by changing the parameter below :
### Schema :
The parameter's configuration schema is :
```yaml
rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               ]" 
 ```   
### Examples: 
 
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
 
                             
### What you need to Know 
'rabbit@' is required by the rabbitmq clustering controller.
 ```
Simple quotes also is required.
Jinja adds a "u" symbol when double quotes " " cercling the [array] are missing. 
End with an example of getting some data out of the system or using it for a little demo
 ```
