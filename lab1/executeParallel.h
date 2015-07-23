// CS 111
//Part 1c

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
