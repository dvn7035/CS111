// UCLA CS 111 Lab 1 command reading
// Summer 2015
// Written by Tien Le and David Nguyen


#include "command.h"
#include "command-internals.h"

#include <error.h>

//////////////////////////////////////////////////////
// Header files
/////////////////////////////////////////////////////
#include <ctype.h>
#include <stdlib.h>
#include "alloc.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
//////////////////////////////////////////////////////
// DEFINITIONS
//////////////////////////////////////////////////////

typedef struct list* list_t;
typedef struct stack* stack_t;

int lineNum = 1;

typedef enum{
	SIMPLE,
	AND_OR_OP,
	SUBSHELL_OP,
	REDIRECTION,
	NEWLINE,
	WHITESPACE,
	COMMENT,
	SEQ,
	END_OF_FILE,
}charType;

typedef enum { false, true} bool;

typedef struct stack
{
	command_t data;
	stack_t next;
	int sizeOfStack;
}stack;

typedef struct list
{
	command_t data;
	list_t head;
	list_t next;
} list;

typedef struct command_stream{
	list_t commands;
}command_stream;


//////////////////////////////////////////////////////
// Stack implementation for commands
//////////////////////////////////////////////////////

stack_t initStack(void)
{
	stack_t t = checked_malloc(sizeof(stack));
	t->next = NULL;
	t->data = NULL;
	t->sizeOfStack = 0;
	return t;
}

void stackPush(stack_t*  mystack, command_t data)
{
	stack_t insert = checked_malloc(sizeof(stack));
	insert->data = data;
	insert->next = *mystack;
	insert->sizeOfStack = (*mystack)->sizeOfStack + 1;
	*mystack = insert;
	return;
}

command_t stackPop(stack_t* mystack)
{
	command_t to_return = (*mystack)->data;
	stack_t to_delete = (*mystack);
	*mystack = (*mystack)->next;
	free(to_delete);
	return to_return;
}

command_t stackPeek(stack_t mystack)
{
	return mystack->data;
}

command_t stackBottom(stack_t mystack)
{
	while(mystack->next != NULL)
		mystack = mystack->next;
	return mystack->data;

}

int stackSize(stack_t mystack){
	return mystack->sizeOfStack;
}


//////////////////////////////////////////////////////
// List implementation for commands
//////////////////////////////////////////////////////

list* initList(void)
{
	return NULL;
}

void listInsert(list_t* mylist, command_t data)
{
	list_t to_insert = checked_malloc(sizeof(list));
	to_insert->data = data;
	to_insert->next = NULL;

	if (*mylist == NULL)
		*mylist = to_insert;
	else
	{
		list_t walk = *mylist;
		list_t prev = NULL;
		while (walk)
		{
			prev = walk;
			walk = walk->next;
		}
		prev->next = to_insert;
	}
	return;
}

//FUNCTION DECLARATIONS

/////////////////////////////////////
//Determines what kind of character the buffer reads
/////////////////////////////////////

static  int determineCharType(char c){
	int type = -1;
	if( isalnum(c)   || (c == '!') || (c == '%')
		|| (c == '+') || (c == ',') || (c == '-') || (c == '.')
		|| (c == '-') || (c == '.') || (c == '/') || (c == ':')
		|| (c == '@') || (c == '^') || (c == '_')){
			type = SIMPLE; }
	if((c == '|') || (c == '&')){type = AND_OR_OP;}
	if((c == '(') || (c == ')')){type = SUBSHELL_OP;}
	if((c == '<') || (c == '>')){type = REDIRECTION;} 
	if(c == '\n'){type = NEWLINE;}
	if(c == '#'){type = COMMENT;}
	if(c == ';'){type = SEQ;}
	if(c == '\0'){type = END_OF_FILE;}
	return type; 
}

/////////////////////////////////////
//Returns the precedence of the command passed to the function
/////////////////////////////////////
static int operatorPrecedence(command_t cmd){
	if(cmd == NULL)
		return 999;
	switch (cmd->type)
	{
	case SIMPLE_COMMAND:
	case SUBSHELL_COMMAND:
		return 0;
	case SEQUENCE_COMMAND:
		return 3;
	case AND_COMMAND:
	case OR_COMMAND:
		return 2;
	case PIPE_COMMAND:
		return 1;
	default:
		error(1,0, "Error in line %d: Called operatorPrecedence with a command that has no defined command type", lineNum);
	}
	return -1; //Error
}

/////////////////////////////////////
// Recursive comment clearing
/////////////////////////////////////
void clearComments(char** cmdStream){
	if(**cmdStream == '#'){
		while(**cmdStream != '\0' &&  **cmdStream != '\n'){
			(*cmdStream)++;
		}
		while(**cmdStream == '\n'){
			(*cmdStream)++;
			lineNum++;
		}
		if(**cmdStream == '#'){
			clearComments(cmdStream);
		}	
	}
	return;
}




////////////////////////////////////
// Initialize a command
///////////////////////////////////
command_t initialize_cmd(int cmd_type){
	command_t cmd = (command_t) malloc(sizeof(struct command));
	cmd-> input = NULL;
	cmd-> output= NULL;
	cmd-> status = -1;
	cmd-> type  = cmd_type;
	return cmd;
}

/////////////////////////////////////
// Parse a word from a buffer
/////////////////////////////////////
int parse_word(char** c, char* wordBuffer, size_t* bufSize, size_t* maxBufSize){

	int foundWord = false;

	//Clear out whitespace
	while(**c == ' '){(*c)++;}
	while(determineCharType(**c) == SIMPLE){
		if(*bufSize == *maxBufSize){ wordBuffer = (char*)checked_grow_alloc(wordBuffer,maxBufSize);}
		//Copy characters to the word buffer as long as we keep finding valid characters
		foundWord = true;
		wordBuffer[*bufSize] = (**c);
		(*bufSize)++;
		(*c)++;
	}
	wordBuffer[*bufSize] = '\0';
	(*bufSize)++;
	return foundWord;
}

/////////////////////////////////////
// Parse IO redirection operators
////////////////////////////////////
command_t parseRedirection(char** cmdStream, command_t cmd){
	size_t bufSizeInput = 0;
	size_t bufSizeOutput = 0;
	size_t maxBufSize = 100;
	//TODO: Handle case where there are multiple inputs. EX: ls < 1 < 2 
	for(;;){
		while(**cmdStream == ' '){(*cmdStream)++;}

		if( **cmdStream == '<') {
			char* inputRedirect = (char*)checked_malloc(maxBufSize * sizeof(char));
			(*cmdStream)++;
			if(parse_word(cmdStream, inputRedirect, &bufSizeInput, &maxBufSize) == false){ 
				return NULL;}
			cmd-> input = inputRedirect;
		} else if (**cmdStream == '>') {
			(*cmdStream)++;
			char* outputRedirect = (char*) checked_malloc(maxBufSize * sizeof(char));
			if(parse_word(cmdStream,outputRedirect, &bufSizeOutput, &maxBufSize) == false){ 
				return NULL;}
			cmd-> output = outputRedirect;
		} else break;
	}

	return cmd;
}

/////////////////////////////////////
// Parse a simple command
/////////////////////////////////////
command_t parseSimpleCmd (char ** cmdStream){
	//Skip whitespace and comments
	while(**cmdStream == ' ') {(*cmdStream)++; }
	
	clearComments(cmdStream);
	if(determineCharType(**cmdStream) != SIMPLE && determineCharType(**cmdStream) != SUBSHELL_OP){
		error(1,0, "Syntax error in line %d: Received a character %c that is not a simple command\n",lineNum, **cmdStream);
	}
	command_t cmd = initialize_cmd(SIMPLE_COMMAND);

	//Setup buffer that will parse through the characters
	int numberOfWords = 0;
	size_t bufSize = 0;
	size_t maxBufSize = 1000;
	char* buffer = (char*)checked_malloc(maxBufSize * sizeof(char));
	//loop searches for a word, places it into the buffer and increments numberOfWords
	for(;;){
		bool foundWord = parse_word(cmdStream, buffer, &bufSize, &maxBufSize);

		if(foundWord == true){
			numberOfWords++;
		} else if ( **cmdStream == '<' || **cmdStream == '>'){
			if( bufSize < 1){
				error(1,0, "Error in line %d: Script contains improperly formatted IO redirection", lineNum);}
			if(parseRedirection(cmdStream, cmd) == NULL){
				error(1,0, "Error in line %d: IO redirection token did not have a valid input/out", lineNum);
			}
		} else if(bufSize <= 1){
			//If there is nothing in the buffer then this is not a command!
			free(buffer);
			free(cmd);
			return NULL;
		} else break;
	}
	//Begin assigning words
	cmd->u.word = (char**)checked_malloc((numberOfWords+1) * sizeof(char*));
	char* currentBufferPosition = buffer;
	//At minimum u.word[0] = '\n'
	cmd->u.word[0] = currentBufferPosition;
	cmd->u.word[numberOfWords] = NULL; 
	//Populate u.word with thec
	int j = 1;
	for(; j < numberOfWords; j++){
		while( *currentBufferPosition != '\0')
			currentBufferPosition++;
		currentBufferPosition++;
		cmd->u.word[j] = currentBufferPosition;
	}
	return cmd;
}


/////////////////////////////////////
// Recursively parse a command
//
/////////////////////////////////////



command_t recursiveParse(char** cmdStream, int subshell){
	//Example test case
	// A || B
	// A is pushed into operand stack, || pushed into operator stack, B is then pushed into operand stack
	// Pop || and place A and B at its child nodes
	stack* operandStack = initStack();
	stack* operatorStack = initStack();

	//Move to the first token-- we will ignore spaces, tabs, and newlines since no commands have been parsed yet
	while(**cmdStream == ' ' || **cmdStream == '\t' || **cmdStream == '\n'){
	if(**cmdStream == '\n'){ lineNum++;}
	(*cmdStream)++;
	 }
	clearComments(cmdStream);
	//Attempt to parse the command assuming it is a simple command
	if(**cmdStream == '\0'){return NULL;}
	command_t cmd = parseSimpleCmd(cmdStream);
	//If cmd points to null, then we must have a subshell command
	if(cmd == NULL){
		if( **cmdStream == '('){
			(*cmdStream)++;
			cmd = initialize_cmd(SUBSHELL_COMMAND);
			//Recursive call and parses inside of subshell
			cmd->u.subshell_command = recursiveParse(cmdStream, true);
			//Check if a subshell command was successfully parsed
			if(cmd->u.subshell_command == NULL){
				error(1,0, "Error in line %d: Script contained improperly formatted subshell command", lineNum);
			}
			// After formatting a subshell command, check for IO redirection
			while(**cmdStream == ' ') {(*cmdStream)++; }
			if ( **cmdStream == '<' || **cmdStream == '>'){
				if(parseRedirection(cmdStream,cmd) == NULL){
					error(1,0, "Error in line %d: Script contains improperly formatted IO redirection", lineNum);
				}
			}
		} else {
		error(1,0, "Syntax error in line %d: Received character %c\n", lineNum, **cmdStream);
		}
	}
	//After this point, we expect cmd to be a properly formatted simple command or a subshell command
	stackPush(&operandStack, cmd);
	//Next, we interpret the next token
	while(1){
		while(**cmdStream == ' '){(*cmdStream)++; }
		//TODO: How do we handle comments?
		//Break condition, reach EOF
		if(**cmdStream == '\0')
			break;

		command_t operator_cmd;

		//Determine what type of operator we are working with
		if( **cmdStream == '&'){
			(*cmdStream)++;
			//Syntax check
			if(**cmdStream != '&'){
				error(1,0, "Syntax error in line %d: Script contains improperly formatted AND command", lineNum);
			}
			operator_cmd = initialize_cmd(AND_COMMAND);
			(*cmdStream)++;
		} else if(**cmdStream == '|'){
			(*cmdStream)++;	
			if(**cmdStream == '|'){
				operator_cmd = initialize_cmd(OR_COMMAND);
				(*cmdStream)++;
			}else{
				operator_cmd = initialize_cmd(PIPE_COMMAND);
			}
		} else if(**cmdStream == ';'){
			(*cmdStream)++;
			break; //TEMPFIX
			operator_cmd = initialize_cmd(SEQUENCE_COMMAND);
		} else if(**cmdStream == '\n'){
			(*cmdStream)++;
			lineNum++;
			if(**cmdStream == '\0' || **cmdStream == '\n'){
				//Reached EOF, break
				if(subshell == true){ error(1,0, "Error in line %d: Open parantheses '(' did not terminate with a matching closing parantheses!\n", lineNum);}
				break;
			}
			if(subshell== true){error(1,0, "Error in line %d: Open Parantheses did not terminate with a matching closing parantheses!\n", lineNum);}
			break; //TEMPFIX remove this and the line above
			operator_cmd = initialize_cmd(SEQUENCE_COMMAND);
		} else if(**cmdStream == ')'){
			//End of subshell command, this makes a complete command and we break
			if( subshell == false){ error(1,0, "Error in line %d: Closing parantheses ')' do not have a matching open parantheses", lineNum);}
			(*cmdStream)++;
			break;
		} else if(determineCharType(**cmdStream) == SIMPLE){
			error(1,0,"Error in line %d: Script contains illegal grammar-- commands must have a valid operator following", lineNum);
			break;
		} else if(determineCharType(**cmdStream) == -1){
			error(1,0,"Error in line %d: Script contains invalid character %c\n",lineNum, **cmdStream);
		}

		//[1] Tree reorganization code here
		int operatorStackPrecedence = operatorPrecedence(stackPeek(operatorStack));
		int currentOpPrecedence     = operatorPrecedence(operator_cmd);
		//If the command at the top of the stack has a higher precedence, pop top two from operand stack and then place into operator_cmd, and then push back in
		while((stackSize(operatorStack) > 0) && (currentOpPrecedence >= operatorStackPrecedence)){
			if(stackSize(operandStack) < 2){
				error(1,0, "Error in line %d: Binary operator contains less than 2 operands!", lineNum);
			}
			command_t cmd_temp = stackPop(&operatorStack);
			cmd_temp->u.command[1] = stackPop(&operandStack);
			cmd_temp->u.command[0] = stackPop(&operandStack);
			stackPush(&operandStack, cmd_temp);
			operatorStackPrecedence = operatorPrecedence(stackPeek(operatorStack));
		}
		stackPush(&operatorStack, operator_cmd);
		//Move to the next token-- this should be a simple commmand or a subshell
		while(**cmdStream == ' '){(*cmdStream)++; }
		clearComments(cmdStream);
		//Before we iterate the loop, we parse for a simple command 
		// Note that here we skip newlines as well-- we eat up all spaces until we reach another command
		while(**cmdStream == ' ' || **cmdStream == '\t' || **cmdStream == '\n'){
			if(**cmdStream == '\n'){lineNum++;}
			(*cmdStream)++; }
		command_t cmdB = parseSimpleCmd(cmdStream);
		if(cmdB == NULL){
			if( **cmdStream == '('){
				(*cmdStream)++;
				cmdB = initialize_cmd(SUBSHELL_COMMAND);
				//Recursive call and parses inside of subshell
				cmdB->u.subshell_command = recursiveParse(cmdStream, true);
				//Check if a subshell command was successfully parsed
				if(cmdB->u.subshell_command == NULL){
					error(1,0, "Error in line %d: Script contained improperly formatted subshell command", lineNum);
				}
				// After formatting a subshell command, check for IO redirection
				while(**cmdStream == ' ') {(*cmdStream)++; }
				if ( **cmdStream == '<' || **cmdStream == '>'){
					if(parseRedirection(cmdStream,cmdB) == NULL){
						error(1,0, "Error in line %d: Script contains improperly formatted IO redirection", lineNum);
					}
				}
			}
		}
		stackPush(&operandStack, cmdB);
	}
	//After exiting the loop after finding a ')' or a '\0', we will then organize the tree again like in [1]
	//TODO: check this logic for consolidating a tree
	while((stackSize(operatorStack) > 0)){

		if(stackSize(operandStack) < 2){
			error(1,0, "Error in line %d: Binary operator contains less than 2 operands!\n", lineNum);
		}
		command_t cmd_temp = stackPop(&operatorStack);
		cmd_temp->u.command[1] = stackPop(&operandStack);
		cmd_temp->u.command[0] = stackPop(&operandStack);
		stackPush(&operandStack, cmd_temp);
	}

	//Sanity check, operand stack should have only one operand
	if((stackSize(operandStack) != 1) || (stackSize(operatorStack) != 0)){
		error(1,0, "Error in line %d: Operand stack is not size 1 and operator stack is not size 0\n", lineNum);
	}
	command_t returnStack = stackPop(&operandStack);
	free(operandStack);
	free(operatorStack);
	return returnStack;
}






command_stream_t
make_command_stream (int (*get_next_byte) (void *),
					 void *get_next_byte_argument)
{
	lineNum = 1;
	//Initialize command stream
	command_stream_t cmdStream = (command_stream_t) checked_malloc(sizeof(struct command_stream));
	//Create a buffer with the entire input
	size_t maxBufSize = 1000;  
	size_t bufSize = 0;
	char* buffer = (char*)checked_malloc(maxBufSize * sizeof(char));
	char* bufferptr = buffer;
	for(;;){
		int c = get_next_byte(get_next_byte_argument);
		if(bufSize >= maxBufSize){
			buffer = (char*) checked_grow_alloc(buffer,&maxBufSize);
		}
		if(c < 0){
			buffer[bufSize] = '\0';
			bufSize++;
			break;
		}
		buffer[bufSize] = (char)c;
		bufSize++;
	}
	//TODO: Did I use this list correctly?
	//Keep inserting complete commands into cmdStream until you reach EOF (recursive parse should return nnull)
	for(;;){
		command_t nextCompleteCommand = recursiveParse(&bufferptr, false);
		if(nextCompleteCommand == NULL){ break;}
		listInsert(&(cmdStream->commands), nextCompleteCommand);
	}
	free(buffer);
	return cmdStream;
}

command_t read_command_stream (command_stream_t s)
{
	list_t ptr = s->commands;
	command_t to_return = NULL;
	if (ptr != NULL)
	{
		s->commands = s->commands->next;
		to_return = ptr->data;
		free(ptr);
	}
	return to_return;
}

