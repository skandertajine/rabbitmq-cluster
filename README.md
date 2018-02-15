# SKALE-5 Ansible role: Rabbitmq
## Description

rabbitmq is a message broker, used to share messages throught the network.

by now this role install a standalone rabbitmq instance with a default user and the administration plugin

## Configuration

you need to setups those sysclt setup in the base role in order to bypass kernel restriction
```
base_sysctl_present:
  - { key: "vm.swappiness", value: "5" }
  - { key: "vm.drop_caches", value: "1" }
  - { key: "net.ipv4.tcp_max_syn_backlog", value: "10000" }
  - { key: "net.core.somaxconn", value: "10000" }
  - { key: "net.core.netdev_max_backlog", value: "10000" }
```

you can overwrite those value

```
rabbitmq_user: "admin"
rabbitmq_password: "@changeme@"

rabbitmq_node_name: rabbit
rabbitmq_ip_adress: '{{ ansible_eth0.ipv4.address }}' #127.0.0.1
rabbitmq_node_port: 5672

```
## logrotate configuration

into logrotate role, you should use this configuration

```
logrotate_confs:
  - name: rabbitmq
    paths:
      - "/var/log/rabbitmq/*"
    options:
      - daily
      - missingok
      - rotate 4
      - compress
      - notifempty
      - create 640 rabbitmq rabbitmq
      - sharedscripts
      - dateext
      - dateformat -%Y-%m-%d
```


## Install

use ansible galaxy requirement
```
- src: git@git.sk5.io:roles/rclone.git
  version: {{ the_tag_you_want }}
  name: rabbitmq
  scm: git
```

## Links

- [rabbitmq docs](https://www.rabbitmq.com/)
- [rabbitmq administration plugin](https://www.rabbitmq.com/management.html)

