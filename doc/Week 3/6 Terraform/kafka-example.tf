terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

###############################################################################
# 1. VPC, Subnet, Security Group
###############################################################################
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_security_group" "kafka_sg" {
  name   = "kafka-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

###############################################################################
# 2. Kafka Broker Instance
###############################################################################
resource "aws_instance" "broker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.kafka_sg.id]
  tags = { Name = "kafka-broker" }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openjdk-11-jre-headless wget
              wget https://downloads.apache.org/kafka/3.5.0/kafka_2.13-3.5.0.tgz -O /tmp/kafka.tgz
              tar xzf /tmp/kafka.tgz -C /opt
              mv /opt/kafka_2.13-3.5.0 /opt/kafka
              cat <<EOT >> /opt/kafka/config/server.properties
              broker.id=1
              listeners=PLAINTEXT://0.0.0.0:9092
              log.dirs=/var/lib/kafka-logs
              zookeeper.connect=localhost:2181
              EOT
              # start Zookeeper & Kafka
              /opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties
              /opt/kafka/bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties
              EOF
}

###############################################################################
# 3. Create Topics (after broker is up)
###############################################################################
resource "null_resource" "topics" {
  depends_on = [aws_instance.broker]

  provisioner "remote-exec" {
    connection {
      host        = aws_instance.broker.public_ip
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }

    inline = [
      # create 4 topics
      "/opt/kafka/bin/kafka-topics.sh --create --topic topic1 --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1",
      "/opt/kafka/bin/kafka-topics.sh --create --topic topic2 --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1",
      "/opt/kafka/bin/kafka-topics.sh --create --topic topic3 --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1",
      "/opt/kafka/bin/kafka-topics.sh --create --topic topic4 --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1",
    ]
  }
}

###############################################################################
# 4. Producer Instances (count = 3)
###############################################################################
resource "aws_instance" "producer" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.kafka_sg.id]
  tags = { Name = "producer-${count.index + 1}" }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openjdk-11-jre-headless wget
              wget https://downloads.apache.org/kafka/3.5.0/kafka_2.13-3.5.0.tgz -O /tmp/kafka.tgz
              tar xzf /tmp/kafka.tgz -C /opt && mv /opt/kafka_2.13-3.5.0 /opt/kafka
              # producer script
              cat <<SCRIPT > /home/ubuntu/produce.sh
              #!/bin/bash
              while true; do
                echo "hello from producer ${count.index + 1}" | /opt/kafka/bin/kafka-console-producer.sh --broker-list ${aws_instance.broker.private_ip}:9092 --topic topic${(count.index % 4) + 1}
                sleep 5
              done
              SCRIPT
              chmod +x /home/ubuntu/produce.sh
              nohup /home/ubuntu/produce.sh &
              EOF

  depends_on = [null_resource.topics]
}

###############################################################################
# 5. Consumer Instances (count = 2)
###############################################################################
resource "aws_instance" "consumer" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.kafka_sg.id]
  tags = { Name = "consumer-${count.index + 1}" }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openjdk-11-jre-headless wget
              wget https://downloads.apache.org/kafka/3.5.0/kafka_2.13-3.5.0.tgz -O /tmp/kafka.tgz
              tar xzf /tmp/kafka.tgz -C /opt && mv /opt/kafka_2.13-3.5.0 /opt/kafka
              # consumer script
              cat <<SCRIPT > /home/ubuntu/consume.sh
              #!/bin/bash
              /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server ${aws_instance.broker.private_ip}:9092 \
                --topic topic${(count.index % 4) + 1} --from-beginning
              SCRIPT
              chmod +x /home/ubuntu/consume.sh
              nohup /home/ubuntu/consume.sh &
              EOF

  depends_on = [null_resource.topics]
}

###############################################################################
# 6. Variables & Outputs
###############################################################################
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-2"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key for remote-exec connections"
  type        = string
}

output "broker_ip" {
  value = aws_instance.broker.public_ip
}

output "producer_ips" {
  value = aws_instance.producer[*].public_ip
}

output "consumer_ips" {
  value = aws_instance.consumer[*].public_ip
}