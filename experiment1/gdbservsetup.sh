#!/bin/sh

#NO LUCK HERE (negotiating ports and reporting the ports back.)

#unfortunately, this is MPICH specific. Dammit.

#HYDI_CONTROL_FD

#PMI_FD
#PMI_RANK
#PMI_SIZE


gdbserver *:0 $@

# from https://serverfault.com/questions/293632/how-do-i-start-a-process-in-suspended-state-under-linux
#(kill -STOP $BASHPID; exec $@ ) &

#gdbserver --attach *:0 $!
