#!/bin/bash

if [ -z $NODE1 ]; then
    echo "NODE is not defined" ; exit
fi

# make sure port 8091 is reachable
i="1"
while :
do
    CB_IP=$(eval echo \$NODE${i})
    echo "checking ${CB_IP}"
    if [ -z ${CB_IP} ]; then
        break
    fi
    while :
    do
        IS_REACHABLE=$(nmap -Pn -p8091 ${CB_IP}| awk "\$1 ~ /^8091\/tcp/ {print \$2}")
        if [ "${IS_REACHABLE}" == "open" ]; then
            echo "${CB_IP} is ready"
            break
        fi
        echo "${CB_IP} is not ready"
        sleep 1
    done
    i=$[${i}+1]
done

function subst() { eval echo -E "$2"; }

echo "Running ./run.sh"
./run.sh

tail -f /dev/null
