
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 13 02 00 00       	call   10022c <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 6c 9f 10 00       	mov    0x109f6c,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 0c 92 10 00 01 	cmpl   $0x1,0x10920c(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 c4 91 10 00       	add    $0x1091c4,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 91 03 00 00       	call   10044c <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d 6c 9f 10 00    	mov    0x109f6c,%ebx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 04             	cmp    $0x4,%eax
  1000e1:	0f 87 43 01 00 00    	ja     10022a <interrupt+0x16f>
  1000e7:	ff 24 85 04 0a 10 00 	jmp    *0x100a04(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000f0:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000f3:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  1000f6:	53                   	push   %ebx
  1000f7:	e9 8e 00 00 00       	jmp    10018a <interrupt+0xcf>
  1000fc:	b8 60 92 10 00       	mov    $0x109260,%eax
  100101:	ba 01 00 00 00       	mov    $0x1,%edx
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
	pid_t id;
        for (id = 1; id < NPROCS; id++) //Check to see if there are any empty processes
        {
                if (proc_array[id].p_state == P_EMPTY)
  100106:	83 38 00             	cmpl   $0x0,(%eax)
  100109:	74 0e                	je     100119 <interrupt+0x5e>
	//   * ???????    There is one other difference.  What is it?  (Hint:
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
	pid_t id;
        for (id = 1; id < NPROCS; id++) //Check to see if there are any empty processes
  10010b:	42                   	inc    %edx
  10010c:	83 c0 54             	add    $0x54,%eax
  10010f:	83 fa 10             	cmp    $0x10,%edx
  100112:	75 f2                	jne    100106 <interrupt+0x4b>
  100114:	83 ca ff             	or     $0xffffffff,%edx
  100117:	eb 65                	jmp    10017e <interrupt+0xc3>
                if (proc_array[id].p_state == P_EMPTY)
                        break;
        }
        if ( id >= NPROCS)  //if the id is not in range of the array, there were no empty processes
                return -1;
        proc_array[id].p_registers = parent->p_registers;  //Copy the parent register
  100119:	6b ea 54             	imul   $0x54,%edx,%ebp
  10011c:	b9 11 00 00 00       	mov    $0x11,%ecx
  100121:	8d 73 04             	lea    0x4(%ebx),%esi
  100124:	8d 85 c4 91 10 00    	lea    0x1091c4(%ebp),%eax
  10012a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10012e:	89 c7                	mov    %eax,%edi
	// Your job is to figure out how to calculate these variables,
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.
	
	// YOUR CODE HERE!
        src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
  100130:	8b 03                	mov    (%ebx),%eax
                if (proc_array[id].p_state == P_EMPTY)
                        break;
        }
        if ( id >= NPROCS)  //if the id is not in range of the array, there were no empty processes
                return -1;
        proc_array[id].p_registers = parent->p_registers;  //Copy the parent register
  100132:	83 c7 04             	add    $0x4,%edi
  100135:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// We have done one for you.
	
	// YOUR CODE HERE!
        src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
        src_stack_bottom = src->p_registers.reg_esp;
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  100137:	8b b5 c4 91 10 00    	mov    0x1091c4(%ebp),%esi
	// Your job is to figure out how to calculate these variables,
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.
	
	// YOUR CODE HERE!
        src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
  10013d:	83 c0 0a             	add    $0xa,%eax
  100140:	c1 e0 12             	shl    $0x12,%eax
        src_stack_bottom = src->p_registers.reg_esp;
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
        uint32_t size = (src_stack_top - src_stack_bottom);
  100143:	89 c7                	mov    %eax,%edi
	// We have done one for you.
	
	// YOUR CODE HERE!
        src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
        src_stack_bottom = src->p_registers.reg_esp;
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  100145:	83 c6 0a             	add    $0xa,%esi
        uint32_t size = (src_stack_top - src_stack_bottom);
  100148:	2b 7b 40             	sub    0x40(%ebx),%edi
        dest_stack_bottom = dest_stack_top - size;
        // YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
        memcpy((void*) dest_stack_top, (void*) src_stack_top, size);
  10014b:	51                   	push   %ecx
	// We have done one for you.
	
	// YOUR CODE HERE!
        src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE;
        src_stack_bottom = src->p_registers.reg_esp;
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
  10014c:	c1 e6 12             	shl    $0x12,%esi
        uint32_t size = (src_stack_top - src_stack_bottom);
        dest_stack_bottom = dest_stack_top - size;
        // YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
        memcpy((void*) dest_stack_top, (void*) src_stack_top, size);
  10014f:	57                   	push   %edi
  100150:	50                   	push   %eax
  100151:	56                   	push   %esi
        dest->p_registers.reg_esp = dest_stack_bottom;
  100152:	29 fe                	sub    %edi,%esi
        src_stack_bottom = src->p_registers.reg_esp;
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
        uint32_t size = (src_stack_top - src_stack_bottom);
        dest_stack_bottom = dest_stack_top - size;
        // YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
        memcpy((void*) dest_stack_top, (void*) src_stack_top, size);
  100154:	89 54 24 18          	mov    %edx,0x18(%esp)
  100158:	e8 c7 03 00 00       	call   100524 <memcpy>
        dest->p_registers.reg_esp = dest_stack_bottom;
  10015d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
        if ( id >= NPROCS)  //if the id is not in range of the array, there were no empty processes
                return -1;
        proc_array[id].p_registers = parent->p_registers;  //Copy the parent register
        copy_stack(proc_array+id, parent);		   //Copy the parent stack 	
        proc_array[id].p_registers.reg_eax = 0;		   //Return 0 for the child process 
        proc_array[id].p_state = parent->p_state;          //set child's state to its parent state
  100161:	83 c4 10             	add    $0x10,%esp
  100164:	8b 54 24 08          	mov    0x8(%esp),%edx
        }
        if ( id >= NPROCS)  //if the id is not in range of the array, there were no empty processes
                return -1;
        proc_array[id].p_registers = parent->p_registers;  //Copy the parent register
        copy_stack(proc_array+id, parent);		   //Copy the parent stack 	
        proc_array[id].p_registers.reg_eax = 0;		   //Return 0 for the child process 
  100168:	c7 85 e4 91 10 00 00 	movl   $0x0,0x1091e4(%ebp)
  10016f:	00 00 00 
        dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE;
        uint32_t size = (src_stack_top - src_stack_bottom);
        dest_stack_bottom = dest_stack_top - size;
        // YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
        memcpy((void*) dest_stack_top, (void*) src_stack_top, size);
        dest->p_registers.reg_esp = dest_stack_bottom;
  100172:	89 70 40             	mov    %esi,0x40(%eax)
        if ( id >= NPROCS)  //if the id is not in range of the array, there were no empty processes
                return -1;
        proc_array[id].p_registers = parent->p_registers;  //Copy the parent register
        copy_stack(proc_array+id, parent);		   //Copy the parent stack 	
        proc_array[id].p_registers.reg_eax = 0;		   //Return 0 for the child process 
        proc_array[id].p_state = parent->p_state;          //set child's state to its parent state
  100175:	8b 43 48             	mov    0x48(%ebx),%eax
  100178:	89 85 0c 92 10 00    	mov    %eax,0x10920c(%ebp)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10017e:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  100181:	83 ec 0c             	sub    $0xc,%esp
  100184:	ff 35 6c 9f 10 00    	pushl  0x109f6c
  10018a:	e8 bd 02 00 00       	call   10044c <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  10018f:	e8 f8 fe ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
  100194:	a1 6c 9f 10 00       	mov    0x109f6c,%eax
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->p_waiting != 0)
  100199:	8b 50 50             	mov    0x50(%eax),%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;
  10019c:	8b 48 20             	mov    0x20(%eax),%ecx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
  10019f:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->p_waiting != 0)
  1001a6:	85 d2                	test   %edx,%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;
  1001a8:	89 48 4c             	mov    %ecx,0x4c(%eax)
		if (current->p_waiting != 0)
  1001ab:	74 1a                	je     1001c7 <interrupt+0x10c>
                {
                        proc_array[current->p_waiting].p_registers.reg_eax = current->p_exit_status;
  1001ad:	6b d2 54             	imul   $0x54,%edx,%edx
                        proc_array[current->p_waiting].p_state = P_RUNNABLE;
                        current->p_waiting = 0;
  1001b0:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
		// for this register out of 'current->p_registers'.
		current->p_state = P_EMPTY;
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->p_waiting != 0)
                {
                        proc_array[current->p_waiting].p_registers.reg_eax = current->p_exit_status;
  1001b7:	89 8a e4 91 10 00    	mov    %ecx,0x1091e4(%edx)
                        proc_array[current->p_waiting].p_state = P_RUNNABLE;
  1001bd:	c7 82 0c 92 10 00 01 	movl   $0x1,0x10920c(%edx)
  1001c4:	00 00 00 
                        current->p_waiting = 0;
                }      
		schedule();
  1001c7:	e8 c0 fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001cc:	a1 6c 9f 10 00       	mov    0x109f6c,%eax
  1001d1:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001d4:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001d7:	83 f9 0e             	cmp    $0xe,%ecx
  1001da:	77 1d                	ja     1001f9 <interrupt+0x13e>
  1001dc:	3b 10                	cmp    (%eax),%edx
  1001de:	74 19                	je     1001f9 <interrupt+0x13e>
		    || proc_array[p].p_state == P_EMPTY
		    || proc_array[p].p_waiting != 0)		//As per mpos-app.h, if sys_wait() is called twice on the same pid, then only one of them will return the actual exit status 
  1001e0:	6b d2 54             	imul   $0x54,%edx,%edx
  1001e3:	8b 9a 0c 92 10 00    	mov    0x10920c(%edx),%ebx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001e9:	85 db                	test   %ebx,%ebx
  1001eb:	74 0c                	je     1001f9 <interrupt+0x13e>
  1001ed:	8d 8a c4 91 10 00    	lea    0x1091c4(%edx),%ecx
  1001f3:	83 79 50 00          	cmpl   $0x0,0x50(%ecx)
  1001f7:	74 09                	je     100202 <interrupt+0x147>
		    || proc_array[p].p_state == P_EMPTY
		    || proc_array[p].p_waiting != 0)		//As per mpos-app.h, if sys_wait() is called twice on the same pid, then only one of them will return the actual exit status 
			current->p_registers.reg_eax = -1;
  1001f9:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100200:	eb 23                	jmp    100225 <interrupt+0x16a>
		    || proc_array[p].p_state == P_EMPTY
		    || proc_array[p].p_waiting != 0)		//As per mpos-app.h, if sys_wait() is called twice on the same pid, then only one of them will return the actual exit status 
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  100202:	83 fb 03             	cmp    $0x3,%ebx
  100205:	75 0b                	jne    100212 <interrupt+0x157>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  100207:	8b 92 10 92 10 00    	mov    0x109210(%edx),%edx
  10020d:	89 50 20             	mov    %edx,0x20(%eax)
  100210:	eb 13                	jmp    100225 <interrupt+0x16a>
		else
		{
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
  100212:	c7 40 20 fe ff ff ff 	movl   $0xfffffffe,0x20(%eax)
			current->p_state = P_BLOCKED;
  100219:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
			proc_array[p].p_waiting = current->p_pid;
  100220:	8b 00                	mov    (%eax),%eax
  100222:	89 41 50             	mov    %eax,0x50(%ecx)
		}
		schedule();
  100225:	e8 62 fe ff ff       	call   10008c <schedule>
  10022a:	eb fe                	jmp    10022a <interrupt+0x16f>

0010022c <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10022c:	53                   	push   %ebx
  10022d:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100230:	68 40 05 00 00       	push   $0x540
  100235:	6a 00                	push   $0x0
  100237:	68 c4 91 10 00       	push   $0x1091c4
  10023c:	e8 47 03 00 00       	call   100588 <memset>
  100241:	b8 c4 91 10 00       	mov    $0x1091c4,%eax
  100246:	31 d2                	xor    %edx,%edx
  100248:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10024b:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10024d:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024e:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_waiting = 0;
  100255:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10025c:	83 c0 54             	add    $0x54,%eax
  10025f:	83 fa 10             	cmp    $0x10,%edx
  100262:	75 e7                	jne    10024b <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_waiting = 0;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100264:	c7 05 6c 9f 10 00 18 	movl   $0x109218,0x109f6c
  10026b:	92 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  10026e:	e8 71 00 00 00       	call   1002e4 <segments_init>
	special_registers_init(current);
  100273:	83 ec 0c             	sub    $0xc,%esp
  100276:	ff 35 6c 9f 10 00    	pushl  0x109f6c
  10027c:	e8 e2 01 00 00       	call   100463 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100281:	e8 2d 01 00 00       	call   1003b3 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100286:	83 c4 0c             	add    $0xc,%esp
  100289:	68 18 0a 10 00       	push   $0x100a18
  10028e:	68 00 07 00 00       	push   $0x700
  100293:	ff 35 00 00 06 00    	pushl  0x60000
  100299:	e8 4c 07 00 00       	call   1009ea <console_printf>
  10029e:	83 c4 10             	add    $0x10,%esp
  1002a1:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1002a6:	e8 4b 01 00 00       	call   1003f6 <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1002ab:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1002ae:	83 fb 01             	cmp    $0x1,%ebx
  1002b1:	77 f3                	ja     1002a6 <start+0x7a>
	console_clear();
  1002b3:	e8 fb 00 00 00       	call   1003b3 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1002b8:	50                   	push   %eax
  1002b9:	50                   	push   %eax
  1002ba:	a1 6c 9f 10 00       	mov    0x109f6c,%eax
  1002bf:	83 c0 34             	add    $0x34,%eax
  1002c2:	50                   	push   %eax
  1002c3:	53                   	push   %ebx
  1002c4:	e8 cf 01 00 00       	call   100498 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1002c9:	a1 6c 9f 10 00       	mov    0x109f6c,%eax
  1002ce:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1002d5:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  1002dc:	89 04 24             	mov    %eax,(%esp)
  1002df:	e8 68 01 00 00       	call   10044c <run>

001002e4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e4:	b8 04 97 10 00       	mov    $0x109704,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e9:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ee:	89 c2                	mov    %eax,%edx
  1002f0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002f3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f4:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1002f9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002fc:	66 a3 b6 1a 10 00    	mov    %ax,0x101ab6
  100302:	c1 e8 18             	shr    $0x18,%eax
  100305:	88 15 b8 1a 10 00    	mov    %dl,0x101ab8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030b:	ba 6c 97 10 00       	mov    $0x10976c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100310:	a2 bb 1a 10 00       	mov    %al,0x101abb
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100315:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100317:	66 c7 05 b4 1a 10 00 	movw   $0x68,0x101ab4
  10031e:	68 00 
  100320:	c6 05 ba 1a 10 00 40 	movb   $0x40,0x101aba
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100327:	c6 05 b9 1a 10 00 89 	movb   $0x89,0x101ab9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10032e:	c7 05 08 97 10 00 00 	movl   $0x80000,0x109708
  100335:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100338:	66 c7 05 0c 97 10 00 	movw   $0x10,0x10970c
  10033f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100341:	66 89 0c c5 6c 97 10 	mov    %cx,0x10976c(,%eax,8)
  100348:	00 
  100349:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100350:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100355:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10035a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10035f:	40                   	inc    %eax
  100360:	3d 00 01 00 00       	cmp    $0x100,%eax
  100365:	75 da                	jne    100341 <segments_init+0x5d>
  100367:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10036b:	ba 6c 97 10 00       	mov    $0x10976c,%edx
  100370:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  100377:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10037e:	66 89 0c c5 6c 97 10 	mov    %cx,0x10976c(,%eax,8)
  100385:	00 
  100386:	c1 e9 10             	shr    $0x10,%ecx
  100389:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10038e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100393:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  100398:	40                   	inc    %eax
  100399:	83 f8 3a             	cmp    $0x3a,%eax
  10039c:	75 d2                	jne    100370 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10039e:	b0 28                	mov    $0x28,%al
  1003a0:	0f 01 15 7c 1a 10 00 	lgdtl  0x101a7c
  1003a7:	0f 00 d8             	ltr    %ax
  1003aa:	0f 01 1d 84 1a 10 00 	lidtl  0x101a84
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003b1:	5b                   	pop    %ebx
  1003b2:	c3                   	ret    

001003b3 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003b3:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003b4:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003b6:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003b7:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1003be:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1003c1:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1003c8:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1003cb:	40                   	inc    %eax
  1003cc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1003d1:	75 ee                	jne    1003c1 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003d3:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003d8:	b0 0e                	mov    $0xe,%al
  1003da:	89 f2                	mov    %esi,%edx
  1003dc:	ee                   	out    %al,(%dx)
  1003dd:	31 c9                	xor    %ecx,%ecx
  1003df:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1003e4:	88 c8                	mov    %cl,%al
  1003e6:	89 da                	mov    %ebx,%edx
  1003e8:	ee                   	out    %al,(%dx)
  1003e9:	b0 0f                	mov    $0xf,%al
  1003eb:	89 f2                	mov    %esi,%edx
  1003ed:	ee                   	out    %al,(%dx)
  1003ee:	88 c8                	mov    %cl,%al
  1003f0:	89 da                	mov    %ebx,%edx
  1003f2:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1003f3:	5b                   	pop    %ebx
  1003f4:	5e                   	pop    %esi
  1003f5:	c3                   	ret    

001003f6 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1003f6:	ba 64 00 00 00       	mov    $0x64,%edx
  1003fb:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1003fc:	a8 01                	test   $0x1,%al
  1003fe:	74 45                	je     100445 <console_read_digit+0x4f>
  100400:	b2 60                	mov    $0x60,%dl
  100402:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100403:	8d 50 fe             	lea    -0x2(%eax),%edx
  100406:	80 fa 08             	cmp    $0x8,%dl
  100409:	77 05                	ja     100410 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10040b:	0f b6 c0             	movzbl %al,%eax
  10040e:	48                   	dec    %eax
  10040f:	c3                   	ret    
	else if (data == 0x0B)
  100410:	3c 0b                	cmp    $0xb,%al
  100412:	74 35                	je     100449 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100414:	8d 50 b9             	lea    -0x47(%eax),%edx
  100417:	80 fa 02             	cmp    $0x2,%dl
  10041a:	77 07                	ja     100423 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10041c:	0f b6 c0             	movzbl %al,%eax
  10041f:	83 e8 40             	sub    $0x40,%eax
  100422:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100423:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100426:	80 fa 02             	cmp    $0x2,%dl
  100429:	77 07                	ja     100432 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10042b:	0f b6 c0             	movzbl %al,%eax
  10042e:	83 e8 47             	sub    $0x47,%eax
  100431:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100432:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100435:	80 fa 02             	cmp    $0x2,%dl
  100438:	77 07                	ja     100441 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10043a:	0f b6 c0             	movzbl %al,%eax
  10043d:	83 e8 4e             	sub    $0x4e,%eax
  100440:	c3                   	ret    
	else if (data == 0x53)
  100441:	3c 53                	cmp    $0x53,%al
  100443:	74 04                	je     100449 <console_read_digit+0x53>
  100445:	83 c8 ff             	or     $0xffffffff,%eax
  100448:	c3                   	ret    
  100449:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10044b:	c3                   	ret    

0010044c <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10044c:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100450:	a3 6c 9f 10 00       	mov    %eax,0x109f6c

	asm volatile("movl %0,%%esp\n\t"
  100455:	83 c0 04             	add    $0x4,%eax
  100458:	89 c4                	mov    %eax,%esp
  10045a:	61                   	popa   
  10045b:	07                   	pop    %es
  10045c:	1f                   	pop    %ds
  10045d:	83 c4 08             	add    $0x8,%esp
  100460:	cf                   	iret   
  100461:	eb fe                	jmp    100461 <run+0x15>

00100463 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100463:	53                   	push   %ebx
  100464:	83 ec 0c             	sub    $0xc,%esp
  100467:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10046b:	6a 44                	push   $0x44
  10046d:	6a 00                	push   $0x0
  10046f:	8d 43 04             	lea    0x4(%ebx),%eax
  100472:	50                   	push   %eax
  100473:	e8 10 01 00 00       	call   100588 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100478:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10047e:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100484:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10048a:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  100490:	83 c4 18             	add    $0x18,%esp
  100493:	5b                   	pop    %ebx
  100494:	c3                   	ret    
  100495:	90                   	nop
  100496:	90                   	nop
  100497:	90                   	nop

00100498 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100498:	55                   	push   %ebp
  100499:	57                   	push   %edi
  10049a:	56                   	push   %esi
  10049b:	53                   	push   %ebx
  10049c:	83 ec 1c             	sub    $0x1c,%esp
  10049f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004a3:	83 f8 01             	cmp    $0x1,%eax
  1004a6:	7f 04                	jg     1004ac <program_loader+0x14>
  1004a8:	85 c0                	test   %eax,%eax
  1004aa:	79 02                	jns    1004ae <program_loader+0x16>
  1004ac:	eb fe                	jmp    1004ac <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1004ae:	8b 34 c5 bc 1a 10 00 	mov    0x101abc(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1004b5:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1004bb:	74 02                	je     1004bf <program_loader+0x27>
  1004bd:	eb fe                	jmp    1004bd <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004bf:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1004c2:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004c6:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1004c8:	c1 e5 05             	shl    $0x5,%ebp
  1004cb:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1004ce:	eb 3f                	jmp    10050f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1004d0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1004d3:	75 37                	jne    10050c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1004d5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004d8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1004db:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004de:	01 c7                	add    %eax,%edi
	memsz += va;
  1004e0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1004e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1004e7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1004eb:	52                   	push   %edx
  1004ec:	89 fa                	mov    %edi,%edx
  1004ee:	29 c2                	sub    %eax,%edx
  1004f0:	52                   	push   %edx
  1004f1:	8b 53 04             	mov    0x4(%ebx),%edx
  1004f4:	01 f2                	add    %esi,%edx
  1004f6:	52                   	push   %edx
  1004f7:	50                   	push   %eax
  1004f8:	e8 27 00 00 00       	call   100524 <memcpy>
  1004fd:	83 c4 10             	add    $0x10,%esp
  100500:	eb 04                	jmp    100506 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100502:	c6 07 00             	movb   $0x0,(%edi)
  100505:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100506:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10050a:	72 f6                	jb     100502 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10050c:	83 c3 20             	add    $0x20,%ebx
  10050f:	39 eb                	cmp    %ebp,%ebx
  100511:	72 bd                	jb     1004d0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100513:	8b 56 18             	mov    0x18(%esi),%edx
  100516:	8b 44 24 34          	mov    0x34(%esp),%eax
  10051a:	89 10                	mov    %edx,(%eax)
}
  10051c:	83 c4 1c             	add    $0x1c,%esp
  10051f:	5b                   	pop    %ebx
  100520:	5e                   	pop    %esi
  100521:	5f                   	pop    %edi
  100522:	5d                   	pop    %ebp
  100523:	c3                   	ret    

00100524 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100524:	56                   	push   %esi
  100525:	31 d2                	xor    %edx,%edx
  100527:	53                   	push   %ebx
  100528:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10052c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100530:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100534:	eb 08                	jmp    10053e <memcpy+0x1a>
		*d++ = *s++;
  100536:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100539:	4e                   	dec    %esi
  10053a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10053d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10053e:	85 f6                	test   %esi,%esi
  100540:	75 f4                	jne    100536 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100542:	5b                   	pop    %ebx
  100543:	5e                   	pop    %esi
  100544:	c3                   	ret    

00100545 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100545:	57                   	push   %edi
  100546:	56                   	push   %esi
  100547:	53                   	push   %ebx
  100548:	8b 44 24 10          	mov    0x10(%esp),%eax
  10054c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100550:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100554:	39 c7                	cmp    %eax,%edi
  100556:	73 26                	jae    10057e <memmove+0x39>
  100558:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10055b:	39 c6                	cmp    %eax,%esi
  10055d:	76 1f                	jbe    10057e <memmove+0x39>
		s += n, d += n;
  10055f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100562:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100564:	eb 07                	jmp    10056d <memmove+0x28>
			*--d = *--s;
  100566:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100569:	4a                   	dec    %edx
  10056a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10056d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10056e:	85 d2                	test   %edx,%edx
  100570:	75 f4                	jne    100566 <memmove+0x21>
  100572:	eb 10                	jmp    100584 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100574:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100577:	4a                   	dec    %edx
  100578:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10057b:	41                   	inc    %ecx
  10057c:	eb 02                	jmp    100580 <memmove+0x3b>
  10057e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100580:	85 d2                	test   %edx,%edx
  100582:	75 f0                	jne    100574 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100584:	5b                   	pop    %ebx
  100585:	5e                   	pop    %esi
  100586:	5f                   	pop    %edi
  100587:	c3                   	ret    

00100588 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100588:	53                   	push   %ebx
  100589:	8b 44 24 08          	mov    0x8(%esp),%eax
  10058d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100591:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100595:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100597:	eb 04                	jmp    10059d <memset+0x15>
		*p++ = c;
  100599:	88 1a                	mov    %bl,(%edx)
  10059b:	49                   	dec    %ecx
  10059c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10059d:	85 c9                	test   %ecx,%ecx
  10059f:	75 f8                	jne    100599 <memset+0x11>
		*p++ = c;
	return v;
}
  1005a1:	5b                   	pop    %ebx
  1005a2:	c3                   	ret    

001005a3 <strlen>:

size_t
strlen(const char *s)
{
  1005a3:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005a7:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005a9:	eb 01                	jmp    1005ac <strlen+0x9>
		++n;
  1005ab:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005ac:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1005b0:	75 f9                	jne    1005ab <strlen+0x8>
		++n;
	return n;
}
  1005b2:	c3                   	ret    

001005b3 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1005b3:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1005b7:	31 c0                	xor    %eax,%eax
  1005b9:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005bd:	eb 01                	jmp    1005c0 <strnlen+0xd>
		++n;
  1005bf:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005c0:	39 d0                	cmp    %edx,%eax
  1005c2:	74 06                	je     1005ca <strnlen+0x17>
  1005c4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1005c8:	75 f5                	jne    1005bf <strnlen+0xc>
		++n;
	return n;
}
  1005ca:	c3                   	ret    

001005cb <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005cb:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1005cc:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005d1:	53                   	push   %ebx
  1005d2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1005d4:	76 05                	jbe    1005db <console_putc+0x10>
  1005d6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1005db:	80 fa 0a             	cmp    $0xa,%dl
  1005de:	75 2c                	jne    10060c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005e0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1005e6:	be 50 00 00 00       	mov    $0x50,%esi
  1005eb:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1005ed:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005f0:	99                   	cltd   
  1005f1:	f7 fe                	idiv   %esi
  1005f3:	89 de                	mov    %ebx,%esi
  1005f5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1005f7:	eb 07                	jmp    100600 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1005f9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1005fc:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1005fd:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100600:	83 f8 50             	cmp    $0x50,%eax
  100603:	75 f4                	jne    1005f9 <console_putc+0x2e>
  100605:	29 d0                	sub    %edx,%eax
  100607:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10060a:	eb 0b                	jmp    100617 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10060c:	0f b6 d2             	movzbl %dl,%edx
  10060f:	09 ca                	or     %ecx,%edx
  100611:	66 89 13             	mov    %dx,(%ebx)
  100614:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100617:	5b                   	pop    %ebx
  100618:	5e                   	pop    %esi
  100619:	c3                   	ret    

0010061a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10061a:	56                   	push   %esi
  10061b:	53                   	push   %ebx
  10061c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100620:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100623:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100627:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10062c:	75 04                	jne    100632 <fill_numbuf+0x18>
  10062e:	85 d2                	test   %edx,%edx
  100630:	74 10                	je     100642 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100632:	89 d0                	mov    %edx,%eax
  100634:	31 d2                	xor    %edx,%edx
  100636:	f7 f1                	div    %ecx
  100638:	4b                   	dec    %ebx
  100639:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10063c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10063e:	89 c2                	mov    %eax,%edx
  100640:	eb ec                	jmp    10062e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100642:	89 d8                	mov    %ebx,%eax
  100644:	5b                   	pop    %ebx
  100645:	5e                   	pop    %esi
  100646:	c3                   	ret    

00100647 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100647:	55                   	push   %ebp
  100648:	57                   	push   %edi
  100649:	56                   	push   %esi
  10064a:	53                   	push   %ebx
  10064b:	83 ec 38             	sub    $0x38,%esp
  10064e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100652:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100656:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10065a:	e9 60 03 00 00       	jmp    1009bf <console_vprintf+0x378>
		if (*format != '%') {
  10065f:	80 fa 25             	cmp    $0x25,%dl
  100662:	74 13                	je     100677 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100664:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100668:	0f b6 d2             	movzbl %dl,%edx
  10066b:	89 f0                	mov    %esi,%eax
  10066d:	e8 59 ff ff ff       	call   1005cb <console_putc>
  100672:	e9 45 03 00 00       	jmp    1009bc <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100677:	47                   	inc    %edi
  100678:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10067f:	00 
  100680:	eb 12                	jmp    100694 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100682:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100683:	8a 11                	mov    (%ecx),%dl
  100685:	84 d2                	test   %dl,%dl
  100687:	74 1a                	je     1006a3 <console_vprintf+0x5c>
  100689:	89 e8                	mov    %ebp,%eax
  10068b:	38 c2                	cmp    %al,%dl
  10068d:	75 f3                	jne    100682 <console_vprintf+0x3b>
  10068f:	e9 3f 03 00 00       	jmp    1009d3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100694:	8a 17                	mov    (%edi),%dl
  100696:	84 d2                	test   %dl,%dl
  100698:	74 0b                	je     1006a5 <console_vprintf+0x5e>
  10069a:	b9 4c 0a 10 00       	mov    $0x100a4c,%ecx
  10069f:	89 d5                	mov    %edx,%ebp
  1006a1:	eb e0                	jmp    100683 <console_vprintf+0x3c>
  1006a3:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006a5:	8d 42 cf             	lea    -0x31(%edx),%eax
  1006a8:	3c 08                	cmp    $0x8,%al
  1006aa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1006b1:	00 
  1006b2:	76 13                	jbe    1006c7 <console_vprintf+0x80>
  1006b4:	eb 1d                	jmp    1006d3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1006b6:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1006bb:	0f be c0             	movsbl %al,%eax
  1006be:	47                   	inc    %edi
  1006bf:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1006c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1006c7:	8a 07                	mov    (%edi),%al
  1006c9:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006cc:	80 fa 09             	cmp    $0x9,%dl
  1006cf:	76 e5                	jbe    1006b6 <console_vprintf+0x6f>
  1006d1:	eb 18                	jmp    1006eb <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1006d3:	80 fa 2a             	cmp    $0x2a,%dl
  1006d6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1006dd:	ff 
  1006de:	75 0b                	jne    1006eb <console_vprintf+0xa4>
			width = va_arg(val, int);
  1006e0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1006e3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1006e4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006e7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1006eb:	83 cd ff             	or     $0xffffffff,%ebp
  1006ee:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1006f1:	75 37                	jne    10072a <console_vprintf+0xe3>
			++format;
  1006f3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1006f4:	31 ed                	xor    %ebp,%ebp
  1006f6:	8a 07                	mov    (%edi),%al
  1006f8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006fb:	80 fa 09             	cmp    $0x9,%dl
  1006fe:	76 0d                	jbe    10070d <console_vprintf+0xc6>
  100700:	eb 17                	jmp    100719 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100702:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100705:	0f be c0             	movsbl %al,%eax
  100708:	47                   	inc    %edi
  100709:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10070d:	8a 07                	mov    (%edi),%al
  10070f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100712:	80 fa 09             	cmp    $0x9,%dl
  100715:	76 eb                	jbe    100702 <console_vprintf+0xbb>
  100717:	eb 11                	jmp    10072a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100719:	3c 2a                	cmp    $0x2a,%al
  10071b:	75 0b                	jne    100728 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10071d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100720:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100721:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100724:	85 ed                	test   %ebp,%ebp
  100726:	79 02                	jns    10072a <console_vprintf+0xe3>
  100728:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10072a:	8a 07                	mov    (%edi),%al
  10072c:	3c 64                	cmp    $0x64,%al
  10072e:	74 34                	je     100764 <console_vprintf+0x11d>
  100730:	7f 1d                	jg     10074f <console_vprintf+0x108>
  100732:	3c 58                	cmp    $0x58,%al
  100734:	0f 84 a2 00 00 00    	je     1007dc <console_vprintf+0x195>
  10073a:	3c 63                	cmp    $0x63,%al
  10073c:	0f 84 bf 00 00 00    	je     100801 <console_vprintf+0x1ba>
  100742:	3c 43                	cmp    $0x43,%al
  100744:	0f 85 d0 00 00 00    	jne    10081a <console_vprintf+0x1d3>
  10074a:	e9 a3 00 00 00       	jmp    1007f2 <console_vprintf+0x1ab>
  10074f:	3c 75                	cmp    $0x75,%al
  100751:	74 4d                	je     1007a0 <console_vprintf+0x159>
  100753:	3c 78                	cmp    $0x78,%al
  100755:	74 5c                	je     1007b3 <console_vprintf+0x16c>
  100757:	3c 73                	cmp    $0x73,%al
  100759:	0f 85 bb 00 00 00    	jne    10081a <console_vprintf+0x1d3>
  10075f:	e9 86 00 00 00       	jmp    1007ea <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100764:	83 c3 04             	add    $0x4,%ebx
  100767:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10076a:	89 d1                	mov    %edx,%ecx
  10076c:	c1 f9 1f             	sar    $0x1f,%ecx
  10076f:	89 0c 24             	mov    %ecx,(%esp)
  100772:	31 ca                	xor    %ecx,%edx
  100774:	55                   	push   %ebp
  100775:	29 ca                	sub    %ecx,%edx
  100777:	68 54 0a 10 00       	push   $0x100a54
  10077c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100781:	8d 44 24 40          	lea    0x40(%esp),%eax
  100785:	e8 90 fe ff ff       	call   10061a <fill_numbuf>
  10078a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10078e:	58                   	pop    %eax
  10078f:	5a                   	pop    %edx
  100790:	ba 01 00 00 00       	mov    $0x1,%edx
  100795:	8b 04 24             	mov    (%esp),%eax
  100798:	83 e0 01             	and    $0x1,%eax
  10079b:	e9 a5 00 00 00       	jmp    100845 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007a0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007a8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007ab:	55                   	push   %ebp
  1007ac:	68 54 0a 10 00       	push   $0x100a54
  1007b1:	eb 11                	jmp    1007c4 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1007b3:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1007b6:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007b9:	55                   	push   %ebp
  1007ba:	68 68 0a 10 00       	push   $0x100a68
  1007bf:	b9 10 00 00 00       	mov    $0x10,%ecx
  1007c4:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007c8:	e8 4d fe ff ff       	call   10061a <fill_numbuf>
  1007cd:	ba 01 00 00 00       	mov    $0x1,%edx
  1007d2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1007d6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1007d8:	59                   	pop    %ecx
  1007d9:	59                   	pop    %ecx
  1007da:	eb 69                	jmp    100845 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1007dc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1007df:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007e2:	55                   	push   %ebp
  1007e3:	68 54 0a 10 00       	push   $0x100a54
  1007e8:	eb d5                	jmp    1007bf <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1007ea:	83 c3 04             	add    $0x4,%ebx
  1007ed:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1007f0:	eb 40                	jmp    100832 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1007f2:	83 c3 04             	add    $0x4,%ebx
  1007f5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007f8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1007fc:	e9 bd 01 00 00       	jmp    1009be <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100801:	83 c3 04             	add    $0x4,%ebx
  100804:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100807:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10080b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100810:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100814:	88 44 24 24          	mov    %al,0x24(%esp)
  100818:	eb 27                	jmp    100841 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10081a:	84 c0                	test   %al,%al
  10081c:	75 02                	jne    100820 <console_vprintf+0x1d9>
  10081e:	b0 25                	mov    $0x25,%al
  100820:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100824:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100829:	80 3f 00             	cmpb   $0x0,(%edi)
  10082c:	74 0a                	je     100838 <console_vprintf+0x1f1>
  10082e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100832:	89 44 24 04          	mov    %eax,0x4(%esp)
  100836:	eb 09                	jmp    100841 <console_vprintf+0x1fa>
				format--;
  100838:	8d 54 24 24          	lea    0x24(%esp),%edx
  10083c:	4f                   	dec    %edi
  10083d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100841:	31 d2                	xor    %edx,%edx
  100843:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100845:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100847:	83 fd ff             	cmp    $0xffffffff,%ebp
  10084a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100851:	74 1f                	je     100872 <console_vprintf+0x22b>
  100853:	89 04 24             	mov    %eax,(%esp)
  100856:	eb 01                	jmp    100859 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100858:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100859:	39 e9                	cmp    %ebp,%ecx
  10085b:	74 0a                	je     100867 <console_vprintf+0x220>
  10085d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100861:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100865:	75 f1                	jne    100858 <console_vprintf+0x211>
  100867:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10086a:	89 0c 24             	mov    %ecx,(%esp)
  10086d:	eb 1f                	jmp    10088e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10086f:	42                   	inc    %edx
  100870:	eb 09                	jmp    10087b <console_vprintf+0x234>
  100872:	89 d1                	mov    %edx,%ecx
  100874:	8b 14 24             	mov    (%esp),%edx
  100877:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10087b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10087f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100883:	75 ea                	jne    10086f <console_vprintf+0x228>
  100885:	8b 44 24 08          	mov    0x8(%esp),%eax
  100889:	89 14 24             	mov    %edx,(%esp)
  10088c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10088e:	85 c0                	test   %eax,%eax
  100890:	74 0c                	je     10089e <console_vprintf+0x257>
  100892:	84 d2                	test   %dl,%dl
  100894:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10089b:	00 
  10089c:	75 24                	jne    1008c2 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10089e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008a3:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1008aa:	00 
  1008ab:	75 15                	jne    1008c2 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1008ad:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008b1:	83 e0 08             	and    $0x8,%eax
  1008b4:	83 f8 01             	cmp    $0x1,%eax
  1008b7:	19 c9                	sbb    %ecx,%ecx
  1008b9:	f7 d1                	not    %ecx
  1008bb:	83 e1 20             	and    $0x20,%ecx
  1008be:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1008c2:	3b 2c 24             	cmp    (%esp),%ebp
  1008c5:	7e 0d                	jle    1008d4 <console_vprintf+0x28d>
  1008c7:	84 d2                	test   %dl,%dl
  1008c9:	74 40                	je     10090b <console_vprintf+0x2c4>
			zeros = precision - len;
  1008cb:	2b 2c 24             	sub    (%esp),%ebp
  1008ce:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1008d2:	eb 3f                	jmp    100913 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008d4:	84 d2                	test   %dl,%dl
  1008d6:	74 33                	je     10090b <console_vprintf+0x2c4>
  1008d8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008dc:	83 e0 06             	and    $0x6,%eax
  1008df:	83 f8 02             	cmp    $0x2,%eax
  1008e2:	75 27                	jne    10090b <console_vprintf+0x2c4>
  1008e4:	45                   	inc    %ebp
  1008e5:	75 24                	jne    10090b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008e7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008e9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008ec:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1008f1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008f4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1008f7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1008fb:	7d 0e                	jge    10090b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1008fd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100901:	29 ca                	sub    %ecx,%edx
  100903:	29 c2                	sub    %eax,%edx
  100905:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100909:	eb 08                	jmp    100913 <console_vprintf+0x2cc>
  10090b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100912:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100913:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100917:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100919:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10091d:	2b 2c 24             	sub    (%esp),%ebp
  100920:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100925:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100928:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10092b:	29 c5                	sub    %eax,%ebp
  10092d:	89 f0                	mov    %esi,%eax
  10092f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100933:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100937:	eb 0f                	jmp    100948 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100939:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10093d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100942:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100943:	e8 83 fc ff ff       	call   1005cb <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100948:	85 ed                	test   %ebp,%ebp
  10094a:	7e 07                	jle    100953 <console_vprintf+0x30c>
  10094c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100951:	74 e6                	je     100939 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100953:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100958:	89 c6                	mov    %eax,%esi
  10095a:	74 23                	je     10097f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  10095c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100961:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100965:	e8 61 fc ff ff       	call   1005cb <console_putc>
  10096a:	89 c6                	mov    %eax,%esi
  10096c:	eb 11                	jmp    10097f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  10096e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100972:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100977:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100978:	e8 4e fc ff ff       	call   1005cb <console_putc>
  10097d:	eb 06                	jmp    100985 <console_vprintf+0x33e>
  10097f:	89 f0                	mov    %esi,%eax
  100981:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100985:	85 f6                	test   %esi,%esi
  100987:	7f e5                	jg     10096e <console_vprintf+0x327>
  100989:	8b 34 24             	mov    (%esp),%esi
  10098c:	eb 15                	jmp    1009a3 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  10098e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100992:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100993:	0f b6 11             	movzbl (%ecx),%edx
  100996:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10099a:	e8 2c fc ff ff       	call   1005cb <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  10099f:	ff 44 24 04          	incl   0x4(%esp)
  1009a3:	85 f6                	test   %esi,%esi
  1009a5:	7f e7                	jg     10098e <console_vprintf+0x347>
  1009a7:	eb 0f                	jmp    1009b8 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1009a9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009ad:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009b2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009b3:	e8 13 fc ff ff       	call   1005cb <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009b8:	85 ed                	test   %ebp,%ebp
  1009ba:	7f ed                	jg     1009a9 <console_vprintf+0x362>
  1009bc:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1009be:	47                   	inc    %edi
  1009bf:	8a 17                	mov    (%edi),%dl
  1009c1:	84 d2                	test   %dl,%dl
  1009c3:	0f 85 96 fc ff ff    	jne    10065f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1009c9:	83 c4 38             	add    $0x38,%esp
  1009cc:	89 f0                	mov    %esi,%eax
  1009ce:	5b                   	pop    %ebx
  1009cf:	5e                   	pop    %esi
  1009d0:	5f                   	pop    %edi
  1009d1:	5d                   	pop    %ebp
  1009d2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009d3:	81 e9 4c 0a 10 00    	sub    $0x100a4c,%ecx
  1009d9:	b8 01 00 00 00       	mov    $0x1,%eax
  1009de:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1009e0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009e1:	09 44 24 14          	or     %eax,0x14(%esp)
  1009e5:	e9 aa fc ff ff       	jmp    100694 <console_vprintf+0x4d>

001009ea <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  1009ea:	8d 44 24 10          	lea    0x10(%esp),%eax
  1009ee:	50                   	push   %eax
  1009ef:	ff 74 24 10          	pushl  0x10(%esp)
  1009f3:	ff 74 24 10          	pushl  0x10(%esp)
  1009f7:	ff 74 24 10          	pushl  0x10(%esp)
  1009fb:	e8 47 fc ff ff       	call   100647 <console_vprintf>
  100a00:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a03:	c3                   	ret    
