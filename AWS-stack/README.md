# AWS/IAC Stack

Terraform script that creates a VPC, a public and private subnet, and a EC2 t2 small instance with two interfaces, one on each subnet.


•	Environment variables
You can provide your credentials via the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY, environment variables, representing your AWS Access Key and AWS Secret Key, respectively. Note that setting your AWS credentials using either these (or legacy) environment variables will override the use of AWS_SHARED_CREDENTIALS_FILE and AWS_PROFILE. The AWS_DEFAULT_REGION and AWS_SESSION_TOKEN environment variables are also used, if applicable:
provider "aws" {}
Usage:
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="secretkey"
$ export AWS_DEFAULT_REGION="us-west-2"


### aws configure
AWS Access Key ID [****************ble:]: XXXXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXXXXXXXXXX
Default region name [provider "aws" {}]: ap-XXXX-X
Default output format [Usage:]:

In this code we have done below activities: (Pre-requiste)
1. Creating New VPC
2. Create GW and attach to NEW_VPC
3. Created one public subnet and attached to route table with Internet GW and second created private subnet which is for private network. 
4. Created user with "user" name and imported the user.pem key to access EC2. 
5. Provision code to create EC2 and getting output with Public and private IP.
6. Make sure we have our user and their key present on workstation.
7. Also make sure you have set aws configure on workstation.

## Initialize Terraform
Initialize terraform to download terrafrom required provider with version mentioned and plugin or modules in case you used them in your code. 

```
$terraform.exe init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 3.4.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 3.4"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## Terraform Plan or apply
Plan will show that what is our desired state mentioned in code and what it will provision. Apply also do the same thing but will require input to complete this task. They both do refresh state but keeps them in in-memory to compare between what is already exists in cloud and what is desired state. 

```
$terraform.exe Apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.node will be created
  + resource "aws_instance" "node" {
      + ami                          = "ami-0b69ea66ff7391e80"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "user"
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Env"  = "dev"
          + "Name" = "Node1"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "new_gw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_route_table.new_public_route will be created
  + resource "aws_route_table" "new_public_route" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "new_public_route"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.a will be created
  + resource "aws_route_table_association" "a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.sg will be created
  + resource "aws_security_group" "sg" {
      + arn                    = (known after apply)
      + description            = "Allow all inbound traffic for 22,80 and 8080."
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/32",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/32",
                ]
              + description      = ""
              + from_port        = 8080
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8080
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/32",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "All_traffic"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "name" = "common"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.private_subnet will be created
  + resource "aws_subnet" "private_subnet" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.2.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "new_subnet"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.public_subnet will be created
  + resource "aws_subnet" "public_subnet" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "new_subnet"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.new_vpc will be created
  + resource "aws_vpc" "new_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.0.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "new_vpc"
        }
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.new_vpc: Creating...
aws_vpc.new_vpc: Still creating... [10s elapsed]
aws_vpc.new_vpc: Creation complete after 12s [id=vpc-0d9391245af83f32f]
aws_subnet.public_subnet: Creating...
aws_subnet.private_subnet: Creating...
aws_internet_gateway.gw: Creating...
aws_security_group.sg: Creating...
aws_subnet.public_subnet: Creation complete after 5s [id=subnet-0a8eab300bcf55546]
aws_subnet.private_subnet: Creation complete after 5s [id=subnet-095d090d9cd55b031]
aws_instance.node: Still destroying... [id=i-05dae5c85511c9475, 20s elapsed]
aws_instance.node: Still destroying... [id=i-05dae5c85511c9475, 30s elapsed]
aws_instance.node: Destruction complete after 36s
aws_instance.node: Creating...
aws_instance.node: Still creating... [10s elapsed]
aws_instance.node: Still creating... [20s elapsed]
aws_instance.node: Still creating... [30s elapsed]
aws_instance.node: Provisioning with 'file'...
aws_instance.node: Still creating... [40s elapsed]
aws_instance.node: Creation complete after 44s [id=i-0b2bca5231df82b96]

Apply complete! Resources: 2 added, 0 changed, 1 destroyed.

Outputs:

EC2_Private_IP = [
  [
    "10.0.1.90",
  ],
]
EC2_Public_IP = [
  [
    "3.235.152.125",
  ],
]
VPC_ID = [
  "vpc-0d9391245af83f32f",
]
```
Above we got output with Public IP thru which we can access EC2 and Private IP which is a secondary interface on EC2 instance. I have placed "user.pem" key to get authenticated and get in. 

### Let's Login into EC2 

```
sudo ssh -i ../../../../../Downloads/keys/user.pem ec2-user@3.235.152.125
[sudo] password for mayank:
The authenticity of host '3.235.152.125 (3.235.152.125)' can't be established.
ECDSA key fingerprint is SHA256:ejGMNLx+zNc8SW9LqQ3FVIww9qVmwvhuhK4dWRMTzvs.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '3.235.152.125' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
41 package(s) needed for security, out of 124 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-10-0-1-90 ~]$ ip r
default via 10.0.1.1 dev eth0
10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.90
169.254.169.254 dev eth0
[ec2-user@ip-10-0-1-90 ~]$ exit
```

