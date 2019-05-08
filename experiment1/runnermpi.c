#include <mpi.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	// Initialize the MPI environment
	MPI_Init(NULL, NULL);
	int my_rank, world_size;
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);

	printf("MPI Hello Runner\n");

	if(argc < 1){
		printf("MPI Hello Runner needs the path of a program to run.\n");
		exit(1);
	}

	int n_exec_args = 0;

	char **execargs = (char**)malloc( (1+n_exec_args)*sizeof(char*) );
	execargs[n_exec_args] = NULL;

	printf("MPI Hello Runner is about to exec(). \n");

	int foo = 0;
	foo = execv(argv[1],execargs);

	if(0 != foo){
		printf("Should not happen.\n");
	}else{
		printf("Should also not happen.\n");
	}


	MPI_Finalize();

}
