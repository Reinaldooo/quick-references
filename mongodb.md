docker run \
 --name containername \
 --restart always \
 -p PORTTOUSE:27017 \
 -e MONGO_INITDB_ROOT_USERNAME=admin \
 -e MONGO_INITDB_ROOT_PASSWORD=senhaadmin \
 -d \
 mongo

docker exec -it mongodb \
 mongo --host localhost -u admin -p senhaadmin --authenticationDatabase admin \
 --eval "db.getSiblingDB('DBNAME').createUser({user: 'USERNAME', pwd: 'minhasenhasecreta', roles: [{role: 'readWrite', db: 'DBNAME'}]})"

# This will create the db and give the user power to read/write. custom port don't

# need to be used here since this is executed inside the container
