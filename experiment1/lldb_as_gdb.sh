#!/bin/sh



#unfortunately, this is MPICH specific. Dammit.

#HYDI_CONTROL_FD

#PMI_FD
#PMI_RANK
#PMI_SIZE

#Stack Exchange snippet https://superuser.com/a/1139116
function random_unused_port {
    local port=$(shuf -i 2000-65000 -n 1)
    netstat -lat | grep $port > /dev/null
    if [[ $? == 1 ]] ; then
        export RANDOM_PORT=$port
    else
        random_unused_port
    fi
}
#end stack exchange snippet

random_unused_port

HOSTNAME=$(hostname)
echo "${HOSTNAME}:${RANDOM_PORT}" > ./port_${PMI_RANK}

exec lldb-server g localhost:${RANDOM_PORT} -- $1
