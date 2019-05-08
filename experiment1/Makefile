
all : hello hellompi runner runnermpi mpispawn

hellompi : mpihello.c
	mpicc -o hellompi -g mpihello.c

hello : hello.c
	mpicc -o hello -g hello.c

runner : testexec.c
	mpicc -o runner -g testexec.c

runnermpi : runnermpi.c
	mpicc -o runnermpi -g runnermpi.c

mpispawn : mpispawn.c
	mpicc -o mpispawn -g mpispawn.c

clean :
	rm -f hello hellompi runner runnermpi mpispawn
