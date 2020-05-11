#!/bin/bash

CLUSTER_VERSION=$1
INI=${2:-default.ini}
CMD=${3:-run.sh}

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
        if [ "${IPV6}" == "true" ]; then
            CB_IP=${CB_IP/[/};CB_IP=${CB_IP/]/}
            IS_REACHABLE=$(nmap -6Pn -p8091 ${CB_IP}| awk "\$1 ~ /^8091\/tcp/ {print \$2}")
        else
            IS_REACHABLE=$(nmap -Pn -p8091 ${CB_IP}| awk "\$1 ~ /^8091\/tcp/ {print \$2}")
        fi
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

mapfile -c 1 -C subst < ${INI} > _${INI}

if [ "${CLUSTER_VERSION}" == "wait" ]; then
	echo "Waiting.."
	tail -f /dev/null
else
	echo "Running ./${CMD} ${CLUSTER_VERSION} _${INI}"
	./${CMD} ${CLUSTER_VERSION} _${INI}
	cp surefire-reports /artifacts || true
fi
