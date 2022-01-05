#!/bin/sh

runtime="10 second"
endtime=$(date -ud "$runtime" +%s)

mytime=$(date -u +%s)
echo $test
echo $endtime
count=0
while [ $(date -u +%s) -le $endtime ]
do
    if [ $count -eq 0  ]
    then
        docker exec -d dockr-alpine-vm git clone https://github.com/gabilner/docker-project.git /home/git
        docker exec -d dockr-alpine-vm python3 /home/gitpyscript.py
    fi
    echo "Time Now: `date +%H:%M:%S`"
    echo "Sleeping for 10 seconds"
    sleep 10
    if [$endtime -lE $mytime   ]
    then
        echo "THE SCRIPT TAKE MORE THEN 10 SECONDS"
        exit 1
    fi
done
