# Rash - the Reborn Again SHell


Rash is a shell scripting language intended to replace bash.
Its goal is to allow simple, readable, understandable and secure shell scripting.
In particular, it aims at the niche currently occupied by Bash programs, and specifically aims to address problems in bash and with bash programs.

Rash was created after frustration with trying to create a set of readable and writable bash scripts, and discovering that:
- the core idea of bash (treating functions and programs in the same way, functions use stdin and generate stdout, core focus on program execution and pipelines of data) are powerful and elegant
- while bash 4 has come a long way, writing
- simple string operations are complex
- passing around data is complex



Major goals
+++++++++++++++++++


Be easy to read
-----------------------

Bash is hard to read and understand.
It uses obscure idioms (eg [[ vs [,), has no (or many) sets of best practices.
While not as "write-only" as perl, it certainly requires a trained eye to read it and to understand it.

Rash aims to be readable to somebody who has never seen a rash script before.



Be easy to write
-----------------------

There are many things that are hard to do in bash, or that don't have a simple idiomatic solution.
Many things that you would consider language builtins (and are in other languages) are provided by other unix programs (such as awk, sed, bc, curl or jq)

- storing and sharing data (have you seen the syntax for array and hashtable operations?)
- regex operations (bash 4 has reasonable regex, but it's not PCRE; sed is awful)
- string operations (how do you trim a string, or convert to uppercase)
- http operations (how do you make an http calls)
- file operations (do you remember all the incantations that [[ supports, or know how to redirect both stderr and stdout to different files)
- integer operations (bash has very basic support, you're expected to use dc, or use awk)
- handling errors in the middle of a set of piped operations
- threading, concurrency, parallelism

It should be straightforward to write Rash programs.



Be harder to make mistakes in
-----------------------

Bash is very easy to make mistakes in, especially security mistakes.
There are two types of flaws that are super common:
- failure to properly read and write to variables
- failure to handle errors in pipelines

While the former can be handled with unpleasant idioms ("${MY_VAR}"), the latter has no good support.

Rash aims to be very difficult to make this sort of mistake in.

Finally, Rash aims to include tools that check and validate programs, to help the programer write safer more secure, and more correct code.


Have tools to convert bash into it
-----------------------

Rash will be no good if only new programs can be written in it.
We intend to provide a tool to convert Bash programs into Rash programs.



Be modern
-----------------------

Lastly, Bash is aimed at the programs we want to write in 2015, not the programs from 1980.
It has native support for JSON, HTTP, integers(!), hashtables, arrays, streams, and string operations.
A little bit of batteries included will go a long way.


Lessor goals
++++++++++++++++++++++++++
- be easy to distribute (static binaries only)
- to be portable
- to be strictly versioned


non-goals
++++++++++++++++++++++++++
- to be useful as an inteactive shell (for now, maybe later, once I figure out what that really means)
- to be synctically similar to bash (as bash did to sh)
- to stick strictly to unixisms such as "do one thing well"
- to be useful for large programs
 - to have a standard library
- to compete with python, perl, ruby, node, etc
- to be "pure" in some sense (eg a lovely functional language)


Language notes
++++++++++++++++++++
- execute external procs with ``
 - returns map
 - stdout and stderr are streams
 - exit code is a promise of a value, will block until execution
 - if operated on using string functions, refers to stdout
- awk: file.read | string.words 3
- regex.match returns list of values
- use pipes liberally for composing functions
- string functions all work on streams. no non-stream operations
 - warning when something function appears to cause blocking a stream
- vars start with $ sign
- statically verify all types
- true and false types - dont use 0/non-zero
- proc.success? instead of checking for zero
- functions receive params as values.
 - string values are really streams with a known input
- can we prevent globals entirely?
- exitcode type?
- should we allow returning values? procs cant do that. Should functions == procs?
 - if we assume there is a return value, how do we choose between stdout and exitcode for procs
- the whole point of bash is that the executed functions have their stdout output
- how to put infix functions within a pipe. Maybe *equal as (==) is not readable.
- let string, arrays, hastables, collections, proc and int have methods, which are the same as piping to string.whatever, arguments using ()
- normally a function returns the output, which then goes into the caller's output, and so on. Do the same here.
-


TODO
++++++++++++++++++++
- what to do for unset variables?
 - dont want to have a maybe type
- translate some scripts
