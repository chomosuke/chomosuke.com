# chomosuke.com
My personal website that also host all my personal project under *.chomosuke.com subdomains.

A single ec2 instance on AWS host chomosuke.com and its subdomains.

It's made up of several components:
- An nginx server that:
	- Act like an HTTPS proxy.
	- Redirect HTTP requests to HTTPS.
	- Redirect requests to appropriate docker containers.
- A python script that:
	- Pull repository from GitHub when needed & checks passed.
	- Build docker images using `Dockerfile` at the root of those repositories.
	- Run container with the docker image.
	- Instruct nginx server to redirect requests to the docker image.
