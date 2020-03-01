# Freifunk München Docker build image

Docker image to build firmware for the [Freifunk München](https://ffmuc.net) community.

The build process is started automatically when the container is run. There is no need to manually run commands inside the container anymore.

## Pull Docker image from Github

	docker login -u USERNAME docker.pkg.github.com
	docker pull docker.pkg.github.com/t0biii/gluon-docker/ffmuc:latest
	docker run --rm --name ffmuc -v "$(pwd)/site-ffm:/site-ffm" docker.pkg.github.com/t0biii/gluon-docker/ffmuc:latest

The Firmware files can be found in `$(pwd)/site-ffm/output` after the container has been successfully run


## Docker-Compose example

See [docker-compose.yml](https://github.com/T0biii/gluon-docker/blob/FFMUC-Test/docker-compose.yml)

## Shell trail (advanced)

This section shows the commands that are needed to run a build with the Docker image. Make sure you know what you are doing before hitting the Enter key.


Clone the repository:

    git clone https://github.com/T0biii/gluon-docker.git
    cd gluon-docker/

Use the following commands on the host to create and run the docker image:

    docker build -t ffmuc-experimental .
    docker run -it --name ffmc ffmuc-experimental 

The container will automatically start the firmware build process.
    
You can run the container with some environment variables to change the version for the build

	docker run --name ffmc -e "FFMUC_REPO=https://github.com/T0biii/site-ffm.git" -e "FFMUC_VERSION=stable" ffmuc-experimental

To start the container with an arbitrary command, you can:

	docker run -it --name ffmc ffmuc-experimental "/bin/bash"

You can run a shell in an existing container with the following command:

    docker exec -it ffmc /bin/bash

To restart the image once it has been stopped:

    docker start -i ffmuc

Once you are done, container and image can be deleted by calling

    docker rm ffmc
    docker rmi ffmuc-experimental

The build needs up to 60 GB of hard disk space. If the docker environment cannot provide the neccessary space, the path `/site-ffm` should be bound to a different directory:

    docker run -it --name ffmuc \
        -v "$(pwd)/site-ffm:/site-ffm" \
        ffmuc-experimental

This will create and bind the directory `site-ffm` in the current working directory to the container's output directories.


