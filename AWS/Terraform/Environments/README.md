# Attica Terraform Starter for AWS

Quick generic terraform startup + Guide with modules for EC2, Autoscaling, LoadBalancer and networking + extra.

## Getting Started

These instructions will get you a copy of the terraform starter project up and running on your local machine for additional development/modifications, setup with Azure via Service Principal and remote storage.

### Prerequisites

- AWS Account and subscription

- Install terraform and add to PATH variable following the official guide https://www.terraform.io/downloads.html
//This template works with Terraform v1.0.1//

- - Verify terraform is added to the path variable by running the command on a terminal

```
$ terraform -help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.
##...
```

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TERRAFORM VARIABLES
# You can easily find the variables to configure if you do a search in all directories with this key word: "***  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

aws_access_key_id               = "[CONFIGURE THIS VARIABLE]"
aws_secret_access_key           = "[CONFIGURE THIS VARIABLE]"
output                          = text
region                          = "[CONFIGURE THIS VARIABLE]"

##This variables can be found on the "credentials" file

# Terraform Remote storage config

Terraform stores state files to compare against your cloud environment when executing plans. The safest way to store state is remotely (in a storage account) to avoid conflicts if more than one developer is making changes on terraform plans. This part of the guide, we'll create the storage with the already included terraform script, and configure terraform to use it for remotely storing state. 

```

Now initialize terraform.

```
terraform init
```

Plan execution for creation of the storage account

```
terraform plan
```

Output should show 47 resources to create, 0 to change, 0 to destroy

Apply the plan

```
terraform apply
```

# 

## Built With

* [Terraform](www.terraform.io) - The web framework used


## Authors

* **Victor Flores** - *Initial template*
* **Fede Gepp** - *General Improvements, generic appsettings, add reddis, add storage.*
* **Victor Flores** - *04/03/2021 - Add modules for: FunctionApp, CosmosDB SQL DB, CosmosDB,Container, Azure Service Bus and Service Bus Topic.*
* **Juan Casabo** - 07/05/2021 - Added AWS template with update for Terraform v1.0.1