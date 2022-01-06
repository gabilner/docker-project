docker ps --format '{{.Names}}'
CONTAINER_NAME="dockr-alpine-vm"
CONTAINER_NAME_NEW=$(docker ps -a --format {{.Names}}| grep -w $CONTAINER_NAME)

echo $CONTAINER_NAME_NEW
echo $CONTAINER_NAME
if [ "$CONTAINER_NAME_NEW" != "$CONTAINER_NAME" ]
then
echo "could not found container $CONTAINER_NAME..."
docker run --name dockr-alpine-vm -d -v /home/jenkins/dockerpro/dockeimg/volumepath:/home/git docker-alpine01 top









else
echo " there is already container with that name"



fi
