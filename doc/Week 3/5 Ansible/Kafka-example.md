# Kafka example
This Ansible playbook will:
- Provision a single-node Kafka broker (with embedded Zookeeper)
- Create 4 topics
- Deploy 3 producer services that continuously write to topics
- Deploy 2 consumer services that continuously read from topics

Run with:
``` bash
ansible-playbook -i inventory.ini deploy-kafka.yml
```
