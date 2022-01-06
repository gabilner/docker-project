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
runtime="10 second"
endtime=$(date -ud "$runtime" +%s)

mytime=$(date -u +%s)
#echo $mytime
#echo $endtime
count=0
while [ $(date -u +%s) -le $endtime ]
do
    if [ $count -eq 0  ]
    then
        
        docker exec -d dockr-alpine-vm python3 /home/gitpyscript.py
        count=1

    fi
   # echo "Time Now: `date +%H:%M:%S`"
   # echo "Sleeping for 10 seconds"
   # sleep 11
   mytime=$(date -u +%s)
    echo "$mytime this mu time"
    echo "$endtime this is endtime"
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
