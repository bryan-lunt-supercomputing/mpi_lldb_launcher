#!/bin/sh

PROGARGS="./hello"
PROGARGS2="./hello2"

rm -f ./port_*

( lldb-server p --server --listen \*:0 --port-offset 1024 -f ./port_0.txt ${PROGARGS} )&
( lldb-server p --server --listen \*:0 --port-offset 1024 -f ./port_1.txt ${PROGARGS2} )&

sleep 5

cat ./port_0.txt
echo ""
cat ./port_1.txt
echo ""

export PORT_A=$(cat ./port_0.txt)
export PORT_B=$(cat ./port_1.txt)

cat > lldb-initfile << EOF
platform select remote-linux
platform settings -w /tmp/

platform connect connect://localhost:${PORT_A}
target list
target create /usr/bin/echo
target list
platform disconnect

target create /usr/bin/echo
platform connect connect://localhost:${PORT_B}
target list
target create /usr/bin/echo
target list
platform disconnect


EOF


exec lldb -S lldb-initfile
