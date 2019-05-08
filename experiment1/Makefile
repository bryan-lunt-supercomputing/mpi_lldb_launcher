
all : hello hellompi runner runnermpi

hellompi : mpihello.c
	mpicc -o hellompi -g mpihello.c

hello : hello.c
		mpicc -o hello -g hello.c

runner : testexec.c
	mpicc -o runner -g testexec.c

runnermpi : mpitestexec.c
		mpicc -o runnermpi -g mpitestexec.c

clean :
	rm -f hello runner
