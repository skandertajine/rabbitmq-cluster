
    Cluster configuration schema
    You can choose the number of clustered rabbitmq's nodes by changing this parameter below :
    
    
    Examples: 
    - 3 Rabitmq Nodes in cluster : 
      rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-0' ,
                               'rabbit@{{ rabbitmq_nodename }}-1' ,
                               'rabbit@{{ rabbitmq_nodename }}-2'
                               ]"
    - 2 Rabitmq Nodes in cluster : 
      rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-0' ,
                               'rabbit@{{ rabbitmq_nodename }}-1' ,
                               ]"
    
    The parameter's configuration schema is :
      
      rabbitmq_cluster_nodes  : "[
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               'rabbit@{{ rabbitmq_nodename }}-ID',
                               ]"
                               
      - 'rabbit@' is required by the rabbitmq clustering controller.
      - Simple quotes also is required.
      - Jinja adds a "u" symbol when double quotes " " cercling the [array] are missing. 
