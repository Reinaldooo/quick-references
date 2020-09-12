sudo docker run --name nomedocontainer -e POSTGRES_PASSWORD=senha -p PORTTOUSE:5432 \
--restart always -d postgres

# i could also use:

<!-- -e POSTGRES_USER=user \
    -e POSTGRES_PASSWORD=minhasenhasecreta \
    -e POSTGRES_DB=dbname \ -->

# --name > container name

# -e > set environment vars

# -p > map ports from the container to host. In this case i'm mapping

# the original port of postgres from 5432 to 6341, so in the host i should

# use 6341. It's good to change the default port to avoid attacks

# --restart always > restart this when the system reboots

# -d > run the container on the background

# the last arg is the image name; If it is not downloaded, it will try to

# look up on docker hub

# // Execute commands inside docker

sudo docker exec -it imagename /bin/bash

# or

sudo docker exec -it imagename bash

# exec > execute a command inside a given container

# -it > means interactive, to exec various commands.

# if i wanted to execute a single comm, i could ommit this

# Now i put the name of the container, and the command

# in this case, it will open up the bash as root

# // Postgres setup

su postgres

# this will log me as the master user postgres to interact

# with the postserver

psql

# now i'm inside the postgres and i can execute sql commands

CREATE DATABASE nome;
CREATE USER nome WITH ENCRYPTED PASSWORD 'password';

# Has to be single quotes

GRANT ALL PRIVILEGES ON DATABASE nomeDB TO nomeUser;
