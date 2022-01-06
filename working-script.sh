#!/bin/sh
#docker ps --format '{{.Names}}'
CONTAINER_NAME="dockr-alpine-vm"
CONTAINER_NAME_NEW=$(docker ps -a --format {{.Names}}| grep -w $CONTAINER_NAME)


echo $CONTAINER_NAME_NEW
echo $CONTAINER_NAME
if [ "$CONTAINER_NAME_NEW" != "$CONTAINER_NAME" ]
then
echo "could not found container $CONTAINER_NAME..."
docker run --name dockr-alpine-vm -d -v /home/jenkins/dockerpro/dockeimg/volumepath:/home/git docker-alpine01 top

sleep 5
###########################   run script in the docker container ##############
docker exec -d dockr-alpine-vm rm -rf /home/git
docker exec -d dockr-alpine-vm git clone https://github.com/gabilner/docker-project.git /home/git
runtime="15 second"
sleep 5
docker exec -d dockr-alpine-vm chmod 755 /home/git/pyscript.py


endtime=$(date -ud "$runtime" +%s)

mytime=$(date -u +%s)
echo "$mytime this is the first mytime"
echo "$endtime this is the endtime"
count=0
while true
do
    if [ $count -eq 0  ]
    then

        docker exec -d dockr-alpine-vm python3 /home/git/pyscript.py
        count=1
       echo "running command python3 pscript"
     fi

FILE=/home/jenkins/dockerpro/dockeimg/volumepath/sample.txt
if [ -f "$FILE" ]; then
    echo "$FILE exists."
    exit 0
fi

   mytime=$(date -u +%s)
#    echo "$mytime this mu time"
#    echo "$endtime this is endtime"
if [ $endtime -lt $mytime   ]
    then
        echo "THE SCRIPT TAKE MORE THEN 10 SECONDS"
        exit 1

    fi
done




#################################################################################

else
echo " there is already container with that name"



fi
