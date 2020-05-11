#! /bin/bash
CB_ENTRY_POINT=$1
KEYWORD=cb_entry_point
HOSTSFILE=/etc/hosts
TEMP_HOSTSFILE=/tmp/hosts

# add "IP cb_entry_point" so client can access by host name cb_entry_point
if [ ! -z ${CB_ENTRY_POINT} ]
then
        echo check ${HOSTSFILE}
        if grep -q ${KEYWORD} ${HOSTSFILE}; then
                # replace
                cp -f ${HOSTSFILE} ${TEMP_HOSTSFILE}
                sed -i "s/\(.*\) ${KEYWORD}/${CB_ENTRY_POINT} ${KEYWORD}/" "${TEMP_HOSTSFILE}"
                echo "$(cat ${TEMP_HOSTSFILE})" > "${HOSTSFILE}"
        else
                echo ${CB_ENTRY_POINT} ${KEYWORD} >> ${HOSTSFILE}
        fi
fi

export PATH=$PATH:/usr/local/go/bin

tail -f /dev/null
