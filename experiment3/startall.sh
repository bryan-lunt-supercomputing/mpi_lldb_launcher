#!/bin/sh

###Snippet from http://stackoverflow.com/questions/59895/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
###end snippet

cp ${SCRIPT_DIR}/../experiment1/hello ./hello
cp ${SCRIPT_DIR}/../experiment1/hello ./hello2

PROGARGS="./hello"
PROGARGS2="./hello2"

rm -f ./port_*

( lldb-server p --server --listen \*:0 --port-offset 1024 -f ./port_0.txt ${PROGARGS} )&
( lldb-server p --server --listen \*:0 --port-offset 1024 -f ./port_1.txt ${PROGARGS2} )&

#Fuckkng race condition I can't yet avoid.
sleep 1

cat ./port_0.txt
echo ""
cat ./port_1.txt
echo ""

export PORT_A=$(cat ./port_0.txt)
export PORT_B=$(cat ./port_1.txt)

export PYTHONPATH=$(lldb -P):${PYTHONPATH}

ipython -i ./mpi_debug.py localhost:${PORT_A} localhost:${PORT_B}

killall lldb-server
