# chomosuke.com
My personal website that also host all my personal project under *.chomosuke.com subdomains.

A single ec2 t4g.nano instance make up the ECS cluster that hosts all chomosuke.com and its subdomains.

This repository contains the definition for the container that is the reverse proxy for the whole cluster.

## How it works
On git push, a [GitHub action](.github/workflows/continuous-deloyment.yml) runs that build the Dockerfile, push it to AWS ECR, add [task-definition.json](task-definition.json) to family `chomosuke-com` with the new image, and update ECS service `chomosuke-com` with the new task-definition.

For this to work on a new AWS account, the following needs to exist:
- ECR repository.
- ECS cluster.
- ECS service already running in aforementioned cluster.
- An IAM user with appropriate permissions with its secret in GitHub secret.

## How to add a repo to a subdomain
To be filled
