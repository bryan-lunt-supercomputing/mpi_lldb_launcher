#!/bin/sh



#unfortunately, this is MPICH specific. Dammit.

#HYDI_CONTROL_FD

#PMI_FD
#PMI_RANK
#PMI_SIZE

lldb-server -p --server --listen \*:0 --port-offset 1024 -f ./ports_${PMI_RANK} $1
