// UCLA CS 111 Lab 1 command execution
// test


#include "command.h"
#include "command-internals.h"

#include <stdio.h>

#include <error.h>
#include <errno.h>
#include <stddef.h>
#include "alloc.h"
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>

//Declarations for data structures used in time travel execution
typedef struct wordNode* wordNode_t;
typedef struct listNode* listNode_t;
typedef struct graphNode* graphNode_t;

typedef struct wordNode
{
	char* data;
	wordNode_t head;
	wordNode_t next;
} wordNode;

//Linked list implementation for graphs
typedef struct listNode
{
	graphNode_t node;
	wordNode_t readlist;
	wordNode_t writelist;

	listNode_t head;
	listNode_t next;

} listNode;

//For creating dependency graphs
typedef struct graphNode
{
	command_t cmd; // Root command tree
	pid_t pid; // Uninitialized means that it has not spawned a child
	graphNode_t* before;
} graphNode;

typedef struct dependencyGraph{
	listNode_t no_dependencies; // Linked list of graphnodes
	listNode_t dependencies;
} dependencyGraph;



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
		if(dup2(fIn, STDIN_FILENO) < 0)
			error(1,0, "Error: Execution of dup2 failed\n");
		if(close(fIn) < 0)
			error(1,0, "Error: Clossing input file failed\n");
	}
	// Check for output
	if (c->output != NULL){
		int fOut = open(c->output, O_CREAT | O_WRONLY | O_TRUNC,
			S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		if(fOut < 0)
			error(1,0, "Error: Unable to find output file %s\n", c->output);
		if(dup2(fOut, STDOUT_FILENO) < 0)
			error(1,0, "Error: Execution of dup2 failed\n");
		if(close(fOut) < 0)
			error(1,0, "Error: Clossing input file failed\n");
	}
	return;
}


void execute(command_t c){

	pid_t pid;
	int status, exitStatus;

	switch(c->type){
	case SIMPLE_COMMAND:
		pid = fork();

		if(pid == 0){
			//If child process
			setRedirection(c);
			//Execute the simple command, print error if execvp returns
			execvp(c->u.word[0], c->u.word);
			error(1,0,"Error: Execution of command failed\n");
		} else if (pid > 0){
			//If parent process
			waitpid(pid, &status, 0);
			int exitStatus = WEXITSTATUS(status);
			//Set status and then exit
			c->status = exitStatus;
			_exit(exitStatus);
		} else if (pid < 0){
			error(1, 0, "Error: Fork failed\n");
		}
		break;
	case AND_COMMAND:
		pid = fork();

		if(pid == 0){
			//If child
			execute(c->u.command[0]);
		} else if(pid > 0){
			waitpid(pid, &status, 0);
			exitStatus = WEXITSTATUS(status);
			// AND COMMAND
			//If status is 0, we run u.command[1], otherwise we exit with whatever status
			if(exitStatus == 0){
				int pid2 = fork();
				if(pid2 == 0){
					execute(c->u.command[1]);
				} else if(pid2 > 0){
					waitpid(pid2, &status, 0);
					exitStatus = WEXITSTATUS(status);
					c->status = WEXITSTATUS(status);
					_exit(exitStatus);
				} else if(pid2 < 0){
					error(1,0, "Error: Fork failed\n");
				}
			} else {
				c->status = exitStatus;
				_exit(exitStatus);
			}
		} else if(pid < 0){
			error(1,0, "Error: Fork failed\n");
		}
		break;
	case OR_COMMAND:
		pid = fork();

		if(pid == 0){
			//If child
			execute(c->u.command[0]);
		} else if(pid > 0){
			waitpid(pid, &status, 0);
			exitStatus = WEXITSTATUS(status);
			// OR COMMAND
			//If status is not equal to 0, we run u.command[1], otherwise we exit with status 0
			if(exitStatus != 0){
				pid_t pid2 = fork();
				if(pid2 == 0){
					execute(c->u.command[1]);
				} else if(pid2 > 0){
					waitpid(pid2, &status, 0);
					exitStatus = WEXITSTATUS(status);
					c->status = exitStatus;
					_exit(exitStatus);
				} else if(pid2 < 0){
					error(1,0, "Error: Fork failed\n");
				}
			} else {
				c->status = exitStatus;
				_exit(exitStatus);
			}
		} else if(pid < 0){
			error(1,0, "Error: Fork failed\n");
		}
		break;
	case SEQUENCE_COMMAND:
		//TODO: Check this logic
		//Sequence command: Execute left subtree, then right
		pid = fork();

		if(pid == 0){
			//Child process executes left subtree, returns
			execute(c->u.command[0]);
		} else if(pid > 0){
			// Parent process sets status code, forks and executes right subtree
			waitpid(pid, &status, 0);
			exitStatus = WEXITSTATUS(status);
			c->u.command[0]->status = exitStatus;

			//Now we execute the right subtree
			pid_t pid2 = fork();
			if(pid2 == 0){
				execute(c->u.command[1]);
			} else if(pid2 > 0){
				waitpid(pid2,&status,0);
				exitStatus = WEXITSTATUS(status);
				c->u.command[1]->status = exitStatus;
				_exit(exitStatus);
			} else if(pid2 < 0){
				error(1,0,"Error: Fork failed\n");
			}
		} else if(pid < 0){
			error(1,0, "Error: Fork failed\n");
		}
		break;
	case SUBSHELL_COMMAND:

		pid = fork();
		//Recursively call execute, but set redirection first
		if(pid == 0){
			//If child process
			setRedirection(c);
			execute(c->u.subshell_command);
		} else if(pid > 0){
			// If parent process
			waitpid(pid, &status, 0);
			exitStatus = WEXITSTATUS(status);
			c-> status = exitStatus;
			_exit(exitStatus);
		} else if(pid < 0){
			error(1,0,"Error: Fork failed\n");
		}
		break;
	case PIPE_COMMAND: ;
		int filedescriptor[2];
		if (pipe(filedescriptor) != 0 )
			error (1, errno, "Pipes could not be initialized\n");
		pid = fork();
		if (pid == 0) //Child process executes left hand side
		{
			close(filedescriptor[0]);
			if(dup2(filedescriptor[1], STDOUT_FILENO) == -1){
				error(1, errno, "Error with executing dup2\n");}
			execute(c->u.command[0]);
		}
		else if (pid > 0) //Parent process waits for child and then executes right hand side
		{
			waitpid(pid,&status,0);
			exitStatus = WEXITSTATUS(status);
			pid_t pid2 = fork();
			if (pid2 < 0)
				error(1, errno, "Error: Fork failed\n");
			else if (pid2 == 0)  //Child executes right hand side
			{
				close(filedescriptor[1]);
				if(dup2(filedescriptor[0], STDIN_FILENO) == -1){
					error(1, errno, "Error with executing dup2\n");}
				execute(c->u.command[1]);
			}
			else if (pid2 > 0) //Parent gets the exit status of both
			{
				close(filedescriptor[0]);
				close(filedescriptor[1]);
				waitpid(pid2, &status, 0);
				int exitStatus2 = WEXITSTATUS(status);
				c->status = exitStatus2;
				_exit(c->status);
			}

		}
		else if (pid < 0)
			error(1,0,"Error: Fork failed\n");
		break;
	default:
		error(1,0, "Error: Invalid command\n");
		break;
	}

	return;
}

void
execute_command (command_t c, int time_travel)
{
	pid_t pid = fork();
	int status;

	if( pid == 0){
		execute(c);
	} else if(pid > 0){
		waitpid(pid, &status, 0);
		int exitStatus = WEXITSTATUS(status);
		c->status = exitStatus;
	} else if(pid < 0){
		error(1,0,"Error: Fork failed\n");
	}
}

//TIME TRAVEL IMPLEMENTATION OF EXECUTE COMMAND

//////////////////////////////////////////////////////
// Linked list implementation for commands
//////////////////////////////////////////////////////

//Instantiates an instance of listnode and returns pointer to itself
listNode_t listNodeInsert(listNode_t* mylist, graphNode_t data)
{
	listNode_t to_insert = checked_malloc(sizeof(listNode));
	to_insert->node = data;
	to_insert->readlist = NULL;
	to_insert->writelist = NULL;
	to_insert->next = NULL;

	if (*mylist == NULL)
		*mylist = to_insert;
	else
	{
		listNode_t walk = *mylist;
		listNode_t prev = NULL;
		while (walk)
		{
			prev = walk;
			walk = walk->next;
		}
		prev->next = to_insert;
	}
	return to_insert;
}

//Wordlist implementation
//For the readlist and writelist implementations

void wordInsert(wordNode_t* mylist, char* data)
{
	wordNode_t to_insert = checked_malloc(sizeof(wordNode));
	to_insert->data = data;
	to_insert->next = NULL;

	if (*mylist == NULL)
		*mylist = to_insert;
	else
	{
		wordNode_t walk = *mylist;
		wordNode_t prev = NULL;
		while (walk)
		{
			prev = walk;
			walk = walk->next;
		}
		prev->next = to_insert;
	}
	return;
}

int wordlistIntersects (const wordNode_t list1, const wordNode_t list2)
{
	wordNode_t list1_ptr = list1;
	wordNode_t list2_ptr = NULL;
	while (list1_ptr)
	{
		list2_ptr = list2;
		while (list2_ptr)
		{
			if (strcmp (list1_ptr->data, list2_ptr->data) == 0 )
				return 1;
			list2_ptr = list2_ptr->next;
		}
		list1_ptr = list1_ptr->next;
	}
	return 0;
}

//////////////////////////////////////////////////////
// Graph implementation for commands
//////////////////////////////////////////////////////

void
processCommand(command_t cmd, listNode_t* node){
	wordNode_t rlist = (*node)->readlist;
	wordNode_t wlist = (*node)->writelist;

	switch(cmd->type){
		case SIMPLE_COMMAND:
			//Add input and output to read/write list if applicable
			//TODO: What about duplicates?
			if(cmd->input != NULL)
				wordInsert( &rlist, cmd->input);
			if(cmd->output != NULL)
				wordInsert( &wlist, cmd->output);
			//Store every word that does not begin with '-'
			//Does this work?
			char **word = cmd->u.word;
			while(*word){
				if( **word != '-')
					wordInsert( &rlist, *word);
				word++;
			}
			break;
			//For subshell, add input and output and recursively call processCommand
		case SUBSHELL_COMMAND:
			if(cmd->input != NULL)
				wordInsert( &rlist, cmd->input);
			if(cmd->output != NULL)
				wordInsert( &wlist, cmd->output);
			processCommand(cmd->u.subshell_command, node);
			break;
		
		case AND_COMMAND:
		case SEQUENCE_COMMAND:
		case OR_COMMAND:
		case PIPE_COMMAND:
			processCommand(cmd->u.command[0], node);
			processCommand(cmd->u.command[1], node);
			break;
		}
	return;
}

//TODO:Dependency 

int
haveDependency (const listNode_t cmdTree1, const listNode_t cmdTree2 )
{
	if (wordlistIntersects(cmdTree1->writelist, cmdTree2->readlist))
		return 1;  //RAW dependency
	if (wordlistIntersects(cmdTree1->writelist, cmdTree2->writelist))
		return 1; //WAW dependency
	if (wordlistIntersects(cmdTree1->readlist, cmdTree2->writelist))
		return 1; //WAR dependency
	return 0;
}

dependencyGraph* buildDependencyGraph (command_stream_t stream)
{
    dependencyGraph* to_return = checked_malloc(sizeof(dependencyGraph));
    to_return->no_dependencies = NULL;
    to_return->dependencies = NULL;

    command_t command = NULL;
    listNode_t newListNode = NULL;
    while ( (command = read_command_stream(stream))
    {

        listInsert(&newListNode, NULL); //Allocate a list node with graphNode field set ot NULL
        processCommand(command, &newListNode);  //newList node will have its RL and WL filled
        graphNode_t newGraphNode = checked_malloc(sizeof(graphNode)); //Allocate a graph node
        newGraphNode->cmd = command; //set it to the command recieved from the stream
        newListNode->node = newGraphNode //set the newListNode's graph to this new graph
        //Will finish tomorrow I need a couple of interfaces for graphNode and listNode where I need to insert a node (not the data itself) into the list. By the way do we even use the head field of listNode
    }
    return to_return;
}


//TODO:Time travel execution function
//Will incorporate everything above to parallelize execution

int executeGraph(dependencyGraph* graph)
{
    executeNoDependencies(graph->no_dependencies);
    executeDependencies(graph->dependencies);
    return 0; //Will change this once i figure out if either of the two functions will return an integer value
}

void executeNoDependencies (listNode_t no_dependencies)
{
 // for (GraphNode i : no_dependencies) // using Java-like syntax. 
    listNode_t list_ptr;
    for (list_ptr = no_dependencies; list_ptr ; list_ptr = list_ptr->next)
    {
        pid_t pid = fork();
        if (pid == 0)
        {
            execute_command(list_ptr->command, 1); // written in 1B. 
            exit(0);
        }
        else
            ;
            //list->pid = pid;
    }
    return; //will change the return value
}


void executeDependencies (listNode_t dependencies)
{
    for ( GraphNode i: dependencies )
    {
        int status;  
        for ( GraphNode j : i->before )
            waitpid(j->pid, NULL, status, 0);
        pid_t pid = fork();
        if ( pid == 0 )
        {
            execute_command(i->command);
            exit(0);
        }
        else
            //i->pid = pid;
    }
    return;
}
