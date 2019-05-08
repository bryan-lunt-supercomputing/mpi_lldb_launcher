#include <mpi.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	int SPAWN_NUMBER = 1;

	// Initialize the MPI environment
	MPI_Init(NULL, NULL);
	int my_rank, world_size;
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);

	int n_exec_args = 0;
	char **execargs = (char**)malloc( (1+n_exec_args)*sizeof(char*) );
	execargs[n_exec_args] = NULL;

	MPI_Info spawn_info;
	MPI_Info_create(&spawn_info);

	MPI_Comm comm_to_children;

	int *outcodes = NULL;

	int foo; (void)foo;
	/*
	//Doesn't map hosts
	foo = MPI_Comm_spawn(argv[1], execargs, SPAWN_NUMBER, spawn_info,
		0,
		MPI_COMM_WORLD, &comm_to_children,
		outcodes);
	*/

	/*
	//Creates separate worlds
	foo = MPI_Comm_spawn(argv[1], execargs, SPAWN_NUMBER, spawn_info,
		my_rank,
		MPI_COMM_WORLD, &comm_to_children,
		outcodes);
	*/

	// https://stackoverflow.com/questions/47743425/controlling-node-mapping-of-mpi-comm-spawn

	// Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

	MPI_Info_set(spawn_info,"host",processor_name);

	SPAWN_NUMBER = world_size;
	foo = MPI_Comm_spawn(argv[1], execargs, SPAWN_NUMBER, spawn_info,
		0,
		MPI_COMM_WORLD, &comm_to_children,
		outcodes);





	MPI_Finalize();

}
