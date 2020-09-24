sudo docker run \
 --name mongodb \
 --restart always \
 -p 2342:27017 \
 -e MONGO_INITDB_ROOT_USERNAME=admin \
 -e MONGO_INITDB_ROOT_PASSWORD=mongo0210 \
 -d \
 mongo

sudo docker exec -it mongodb \
 mongo --host localhost -u admin -p mongo0210 --authenticationDatabase admin \
 --eval "db.getSiblingDB('api').createUser({user: 'worker', pwd: 'mongo0210', roles: [{role: 'readWrite', db: 'api'}]})"

# This will create the db and give the user power to read/write. custom port don't

# need to be used here since this is executed inside the container

# Create tunnel to access remote mongo port on my pc

# 3337 locally will be 6379 remotes

ssh -L 3337:127.0.0.1:6379 user@host -N -p 2341
