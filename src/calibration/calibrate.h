

#include "unistd.h"
#if _POSIX_TIMERS
#include <time.h>
#define HAVE_CLOCKGETTIME 1
#else
#include <sys/time.h>
#define HAVE_GETTIMEOFDAY 1
#endif
#include "mpi.h"
void* get_send_buffer();
void* get_recv_buffer();
unsigned long long get_time();
void my_sleep(unsigned long long length);
void print_in_file(const char* func, int count, unsigned long long start_time, unsigned long long total_time);

MPI_Comm get_comm();