# Project Title

Rabbitmq is a message broker, used to share messages throught the network.

By now this role installs a pre-configured cluster of rabbitmq's instances on GCP with a default user and the administration plugin.
## Architecture
![alt text](https://github.com/skandertajine/rabbitmq-cluster/blob/master/architecture.png)




## Data persistancy 

The node's exchange data is mirrored and real-time synchronized between the nodes so that in case of interruption (desired or not) of one or multiple nodes , it ( the data ) is always(SLA xx,xxx%) safly persisted in the remaning alive node.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To use this tool book properly you need to download and install Terraform 

```
Give examples
```

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc



# Rabbitmq Cluster w/ Ansible + Terraform
### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

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
### Examples : 
 
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
