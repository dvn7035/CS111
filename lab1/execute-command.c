// UCLA CS 111 Lab 1 command execution
// test


#include "command.h"
#include "command-internals.h"

#include <error.h>

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */

void execute(command_t c);
void setRedirection(command_t c);

int
command_status (command_t c)
{
  return c->status;
}


void setRedirection(command_t c){
	//Check for input
	if (c->input != NULL){
		//TODO: Check permissions for input/output files
		int fIn = open(c->input, O_RDONLY,
						S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		if(fIn < 0)
			error(1,0, "Error: Unable to find input file %s\n", c->input);
		if(dup2(fIn, 0) < 0)
			error(1,0, "Error: Execution of dup2 failed\n");
		if(close(fIn) < 0)
			error(1,0, "Error: Clossing input file failed\n");
	}
	// Check for output
	if (c->output != NULL){
		int fOut = open(c->input, O_CREAT | O_WRONLY | O_TRUNC,
						S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		if(fOut < 0)
			error(1,0, "Error: Unable to find output file %s\n", c->output);
		if(dup2(fOut, 0) < 0)
			error(1,0, "Error: Execution of dup2 failed\n");
		if(close(fOut) < 0)
			error(1,0, "Error: Clossing input file failed\n");
	}
	return;
}


void execute(command_t c){
	switch(c->type){
	case SIMPLE_COMMAND:
		int pid = fork();
		int status;		

		if(pid == 0){
			//If child process
			setRedirection(c);
			//Execute the simple command, print error if execvp returns
			execvp(c->u.word[0], c->u.word);
			error(1,0 "Error: Execution of command failed\n");
		} else if (pid > 0){
			//If parent process
			waitpid(pid, &status, 0);
			int exitStatus = WEXITSTATUS(status);
			//Set status and then break
			c->status = exitStatus;
		} else if (pid < 0){
			error(1, 0, "Error: Fork failed\n");
		}
		break;
	case AND_COMMAND:
		int pid = fork();
		int status;	
		
		if(pid == 0){
			//If child
			execute(c->u.command[0]);
		} else if(pid > 0){
			waitpid(pid, &status, 0);
			int exitStatus = WEXITSTATUS(status);
			// AND COMMAND
			//If status is 0, we run u.command[1], otherwise we exit with whatever status
			if(exitStatus == 0){
				execute(c->u.command[1]);
				int pid2 = fork();

				if(pid2 == 0){
					execute(c->u.command[1]);
				} else if(pid2 > 0){
					waitpid(pid2, &status, 0);
					exitStatus = WEXITSTATUS(status);

					c->status = WEXITSTATUS(status);
				} else if(pid2 < 0){
					error(1,0, "Error: Fork failed\n");
				}
			} else {
				c->status = exitStatus;
				exit(exitStatus);
			}
		} else if(pid < 0){
			error(1,0, "Error: Fork failed\n");
		}
		break;
	case OR_COMMAND:
		int pid = fork();
		int status;	
		
		if(pid == 0){
			//If child
			execute(c->u.command[0]);
		} else if(pid > 0){
			waitpid(pid, &status, 0);
			int exitStatus = WEXITSTATUS(status);
			// OR COMMAND
			//If status is not equal to 0, we run u.command[1], otherwise we exit with status 0
			if(exitStatus != 0){
				execute(c->u.command[1]);
				int pid2 = fork();

				if(pid2 == 0){
					execute(c->u.command[1]);
				} else if(pid2 > 0){
					waitpid(pid2, &status, 0);
					exitStatus = WEXITSTATUS(status);

					c->status = WEXITSTATUS(status);
				} else if(pid2 < 0){
					error(1,0, "Error: Fork failed\n");
				}
			} else {
				c->status = exitStatus;
				exit(exitStatus);
			}
		} else if(pid < 0){
			error(1,0, "Error: Fork failed\n");
		}
		break;
	case SEQUENCE_COMMAND:
		break;
	case SUBSHELL_COMMAND:
		break;
	case PIPE_COMMAND:
		break;
	default:
		error(1,0 "Error: Invalid command\n");
		break;
	}

return;
}

void
execute_command (command_t c, int time_travel)
{
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
  
	if(time_travel == 1)
		error (1, 0, "command execution not yet implemented");
}
