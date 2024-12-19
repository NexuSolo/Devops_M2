#!/bin/bash

docker container run -it --rm -v $(pwd)/Devops/Terraform:/workspace -v ~/.azure:/root/.azure -w /workspace terraform-azure-cli terraform destroy -auto-approve