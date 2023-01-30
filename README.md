# chomosuke.com
My personal website that also host all my personal project under *.chomosuke.com subdomains.

A single ec2 t4g.nano instance make up the ECS cluster that hosts all chomosuke.com and its subdomains.

This repository contains the definition for the container that is the reverse proxy for the whole cluster.

## How it works
On git push, a [CircleCI pipeline](./.circleci/config.yml) runs that build the Dockerfile, push it to AWS ECR public repository `m4l5t7p6/chomosuke-com`, update task definition of `chomosuke-com` family with the new image, and update ECS service `chomosuke-com` with the new task-definition.

For this to work on a new AWS account, the following needs to exist:
- ECR repository.
- ECS cluster.
- An IAM user with appropriate permissions.
- Environment variables in CircleCI:
	- AWS_ACCESS_KEY_ID
	- AWS_SECRET_ACCESS_KEY
	- AWS_ECR_REGISTRY_ID
	- AWS_REGION

## How to add a repo to a subdomain
- Copy [templates/nginx.conf](./templates/nginx.conf) into [nginx_conf.d](./nginx_conf.d) and rename it with an appropriate name.
	- Replace `<SUBDOMAIN>` with the desirable subdomain.
	- Replace `<PORT>` with a port that isn't used by any other subdomain in [nginx_conf.d](./nginx_conf.d).
- Copy [templates/config.yml](./templates/config.yml) into `.circleci` directory of the project.
	- Replace `<CONTAINER_NAME>` with a suitable name. The convention is to make it the same as `<SUBDOMAIN>`.
- Comment out the second jobs at the bottom and run it on CircleCI. This should push the docker image to `chomosuke-com` ECR repository.
- Create task definition with the newly pushed image.
	- [templates/task-definition.json](./templates/task-definition.json) can be used as a starting point.
	- Make sure that container name and family name match the `<CONTAINER_NAME>` chosen earlier
	- Make sure that `"portMappings"` map to the previously chosen `<PORT>`.
	- Make sure that `"image"` is the URI of the newly pushed image.
- Deploy the task definition to `chomosuke-com` cluster. Make sure the service name is the same as `<CONTAINER_NAME>`.
- Modify IAM user `chomosuke-com-cd` with permission to deploy to the new service and pass any role that might be needed by the service.
- Uncomment the second part, commit and push the changes.

Note that all image share `chomosuke-com` public repository. Make sure no secret are in the image
