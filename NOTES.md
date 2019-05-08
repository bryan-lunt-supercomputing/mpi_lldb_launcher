After initial experiments, I think that MPI_Comm_spawn support is too thin to trust.

We also want to use this under MPICH 3.2 using my custom Singularity launcher.

So, what we plan on doing is much like the "reverse shell" design pattern that
hackers use.

In the end, we're going to do the following:

1) Start a debugging manager daemon thingy (technical term) on the frontend.
	This will listen for connections that will be used to establish debugging.
	First version: Just need to know the addresses and ports for remote debuggers.
	Later versions: May handle/manage the connections to the debuggers.

2) Use MPI to run a non-MPI startup program on every node.
	This will negotiate a debugger connection with the manager daemon,
	Then it will start an instance of the target program under a (remote) debugger.
	Could be a BASH script or fork()/exec(), or whatever.
