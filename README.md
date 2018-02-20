# Rabbitmq Cluster w/ Terraform & Ansible

Rabbitmq is a message broker, used to share messages throught the network.

By now this role installs a pre-configured cluster of rabbitmq's instances on GCP with a default user and the administration plugin.

## Architecture
![alt text](https://github.com/skandertajine/rabbitmq-cluster/blob/master/architecture.png)
## Data persistancy 

The node's exchange data is mirrored and real-time synchronized between the nodes so that in case of interruption (desired or not) of one or multiple nodes , it ( the data ) is always(SLA xx,xxx%) safly persisted in the remaning alive node.


## Getting Started
### Prerequisites
### Installing
## Running the tests
## Deployment

## Built With
* [Ansible](https://www.ansible.com) - Configuration Manager
* [Terraform](https://www.terraform.io) - Infrastructure as code.
* [GCP](https://rometools.github.io/rome/) - Cloud Platform deployed on.

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

## Authors

* **Skander Tajine ** - *Initial work* - [SkanderTajine](https://github.com/SkanderTajine)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

