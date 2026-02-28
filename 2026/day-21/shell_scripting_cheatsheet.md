### Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide
----
#### Task 1: Basics
**Document the following with short descriptions and examples:**

- **Shebang (#!/bin/bash) — what it does and why it matters**
 **Answer:**

A shebang is the very first line in a script: 
- #!/bin/bash **OR**   
- #!/bin/sh  **OR** 
- #!/bin/zsh 
```#! → called shebang (or hashbang)```

```/bin/bash → path to the interpreter (program that runs the script)```

**Purpose:**
-  Run this file using the Bash shell located at /bin/bash.
- Ensures correct interpreter.If we dont specify the  shebang, the script may run with the wrong shell, which can cause errors.



**Running a script — chmod +x, ./script.sh, bash script.sh**

**chmod +x:** Gives the execcution permission to run the script.
**./scripts:** Helps to execute the script.
. → current directory

/ → path separator

script.sh → file name

**bash script.sh:** Runs the script using Bash directly.This means "Open bash and give it this file to execute.”
- [x] Important:

- [ ] Execute permission is not required

- [ ] Shebang is not required

- [ ] It will always use Bash


 **Comments — single line (#) and inline**

Comments are used to explain code.
They are ignored by the shell and not executed.Anything after # on a line is treated as a comment.

- [x] Sinlge-line Comment
-  #This is a single-line comment
- echo "Hello"
The first line is ignored.
Only echo "Hello" runs.
**Example**
   - #!/bin/bash
  - #This script prints a welcome message
echo "Welcome to DevOps"

- [x] Inline Comment

Comments can be added after a command on the same line.
**Example:**
  - echo "Hello"  # This prints Hello

   - Everything after # is ignored.






- **Variables — declaring, using, and quoting ($VAR, "$VAR", '$VAR')**



 1️⃣ Declaring a Variable

In Bash, $ is not used while assigning.

**Example:**

name="ABC"
age=17

No $ during assignment and space should not be in between.

2️⃣ Using a Variable

 $ is used  when accessing the value.
**Example:**
- echo $name
 **Output:** Leena

- curly braces can also be used :
**Example:**
echo ${name}

3️⃣ Quoting Variables

A very important feature in shell scripting.

There are three common forms:

- [ ]   $VAR

name="ABC"
echo $name

**Output:**

ABC


**Example:**

- mkdir $name

If name="My Folder", Bash sees it as:

mkdir My Folder


- [ ] "$VAR" (Double Quotes) , Recommended

echo "$name"

Double quotes:

- Prevent word splitting

- Preserve spaces

- Allow variable expansion

**Example:**

name="My Folder"
mkdir "$name"

Creates one folder correctly.

- [ ] '$VAR' (Single Quotes)

echo '$name'

**Output:**

$name

Single quotes:

- Prevent variable expansion

- Treat everything literally

- So $name is printed as text, not value.


**Example Script**

 #!/bin/bash

name="Leena Rashid"

echo $name
echo "$name"
echo '$name'

Output:

ABC
ABC
$name







 **Reading user input — read**

**Answer:**
The read command is used to take input from the user (keyboard) and store it in a variable.

**Example**

 #!/bin/bash
 echo "Enter your name:"
read name
echo "Hello $name"
**Output:**
Enter your name:
ABC
Hello ABC

`-p ` flag is used for direct prompt.


- **Command-line arguments**

- [ ]  $0 — Script Name

echo $0: Prints the name of the script being executed.

**Example:**

./myscript.sh hello

Inside script:

echo $0

**Output:**

./myscript.sh
🔹 $1, $2, $3 — Positional Parameters

$1 → First argument

$2 → Second argument

$3 → Third argument

**Example script:**

 #!/bin/bash
echo "First: $1"
echo "Second: $2"

Run:

./script.sh Leena DevOps

Output:

First: AWS
Second: DevOps
🔹 $# — Number of Arguments
 
 echo $#: Prints how many arguments were passed.

**Example:**

./script.sh a b c

Inside script:

echo $#

**Output:**


🔹 $@ — All Arguments

echo "$@": Represents all arguments as separate words.

**Example:**

./script.sh one two three

Inside script:

for arg in "$@"

do
  echo $arg
done

**Output:**

one
two
three



🔹 $? — Exit Status of Last Command

echo $?:Shows exit status of the previous command.

0 → Success

Non-zero → Error

**Example:**

ls file.txt
echo $?

If file exists:

0

If file doesn’t exist:

2
**Complete Example Script**
 #!/bin/bash

echo "Script name: $0"

echo "Total arguments: $#"

echo "All arguments: $@"

echo "First argument: $1"

ls notfoundfile
echo "Exit status of ls: $?"

Run:

./script.sh hello world
**Output Summary:**
- [ ] Variable	Meaning
$0--Script name

$1, $2--Positional arguments

$#--Total number of arguments

$@--All arguments

$?--Exit status of last command

-----
#### Task 2: Operators and Conditionals
**Document with examples:**

**String comparisons — =, !=, -z, -n**

1️⃣ = (Equal To)

Checks if two strings are equal.

if [ "$name" = "ABC" ]; then
    echo "Name matches"
fi

If name="ABC" → Correct
If name="XYZ" → Incorrect
- quote variables to avoid errors.

 2️⃣ != (Not Equal To)

Checks if two strings are different.

if [ "$name" != "Admin" ]; then
    echo "Access allowed"
fi

If name="ABC" → Correct
If name="Admin" → Incorrect

 3️⃣ -z (String is Empty)

Checks if string length is zero (empty).

if [ -z "$name" ]; then
    echo "Name is empty"
fi

If:

name=""

Then → Correct

If:

name="ABC"

Then →  Incorrect

 4️⃣ -n (String is NOT Empty)

Checks if string length is non-zero.

if [ -n "$name" ]; then
    echo "Name is not empty"
fi

If:

name="ABC"

Then → Correct

If:

name=""

Then → Incorrect

**Example**
 #!/bin/bash

read -p "Enter your name: " name

if [ -z "$name" ]; then
 
    echo "You did not enter anything"
elif [ "$name" = "ABC" ]; then
 
    echo "Welcome ABC"
else
    echo "Hello $name"
fi

- [X] **Comparison Table**
=	Strings are equal
!=	Strings are not equal
-z	String is empty
-n	String is not empty


----

**Integer comparisons — -eq, -ne, -lt, -gt, -le, -ge**


 - **-eq (Equal)**

Checks if two numbers are equal.

if [ "$a" -eq "$b" ]; then
    echo "Numbers are equal"
fi

Example:

a=10
b=10

**Output** True

- **-ne (Not Equal)**

Checks if two numbers are different.

if [ "$a" -ne   "$b" ]; then
    echo "Numbers are not equal"
fi

- **-lt (Less Than)**
if [ "$a" -lt  "$b" ]; then
    echo "a is less than b"
fi
- **-gt (Greater Than)**

 if [ "$a" -gt   "$b" ]; then
    echo "a is greater than b"
fi
- **-le (Less Than or Equal)**
if [ "$a" -le "$b" ]; then
    echo "a is less than or equal to b"
fi

- **-ge (Greater Than or Equal)**
if [ "$a" -ge "$b" ]; then
    echo "a is greater than or equal to b"
fi
**Example**
 #!/bin/bash

   read -p "Enter first number: " a
   read -p "Enter second number: " b

   if [ "$a" -gt "$b" ]; then
    echo "$a  is greater than $b"

   elif [ "$a" -lt "$b" ]; then
    echo "$a is less than $b"
   else
    echo "Both numbers are equal"
fi 


---


**File test operators — -f, -d, -e, -r, -w, -x, -s**
 1️⃣ -f → Regular File Exists

Checks if a file exists and is a regular file (not a directory).

if [ -f "file.txt" ]; then
    echo "File exists"
fi

- True if:

file.txt exists

It is a normal file

2️⃣ -d → Directory Exists

Checks if a directory exists.

if [ -d "myfolder" ]; then
    echo "Directory exists"
fi
3️⃣ -e → Exists (File or Directory)

Checks if a file OR directory exists.

if [ -e "test" ]; then
    echo "File or directory exists"
fi

-  Works for:

Regular file

Directory

Symbolic link

etc.

 4️⃣ -r → Read Permission

Checks if file is readable.

if [ -r "file.txt" ]; then
    echo "File is readable"
fi
5️⃣ -w → Write Permission

Checks if file is writable.

if [ -w "file.txt" ]; then
    echo "File is writable"
fi
6️⃣ -x → Execute Permission

Checks if file is executable.

if [ -x "script.sh" ]; then
    echo "File is executable"
fi
7️⃣ -s → Not Empty

Checks if file exists and is not empty (size > 0).

if [ -s "file.txt" ]; then
    echo "File is not empty"
fi

If file is empty → False
If file has content → True

**Example**
 #!/bin/bash

file="example.txt"

if [ -e "$file" ]; then
    echo "File exists"

    if [ -f "$file" ]; then
        echo "It is a regular file"
    fi

    if [ -s "$file" ]; then
        echo "File is not empty"
    else
        echo "File is empty"
    fi
else
    echo "File does not exist"
fi



**if, elif, else syntax**

Conditional statements in Bash let you execute commands based on conditions.

**Example**
 #!/bin/bash

read -p "Enter a number: " num

if [ "$num" -gt 0 ]; then
 
    echo "Number is positive"
elif [ "$num" -lt 0 ]; then
 
    echo "Number is negative"
else
    echo "Number is zero"
fi


**Logical operators — &&, ||, !**

 1️⃣ && — AND Operator

Executes the next command only if the previous command succeeds (exit status 0).

In conditions, it means both conditions must be true.

**Example:** With commands
`mkdir myfolder && echo "Folder created successfully"`

echo runs only if mkdir succeeds.


- [x] Both conditions must be true.


2️⃣ || — OR Operator

Executes the next command only if the previous command fails (non-zero exit status).

In conditions, it means at least one condition is true.

**Example:** With commands
`mkdir myfolder || echo "Folder already exists"`

echo runs only if mkdir fails.
 -[x] If any of two conditions become true,output would be true.
3️⃣ ! — NOT Operator

Inverts the condition.

True becomes false, false becomes true.

**Example:**
read -p "Enter a file name: " file
if [ ! -f "$file" ]; then
    echo "File does not exist"
fi

- [x]  negates -f "$file" (file exists)

 

- Case statements — case ... esac

The case statement is used to match a value against multiple patterns.
It’s cleaner than multiple if-elif-else statements when checking one variable against many possibilities.
 **Example**

 #!/bin/bash

read -p "Enter a color (red/green/blue): " color

case "$color" in
    red)
        echo "You chose Red"
        ;;
    green)
        echo "You chose Green"
        ;;
    blue)
        echo "You chose Blue"
        ;;
    *)
        echo "Unknown color"
        ;;
esac

- [x] If user enters green, output:

 **Output:** You chose Green
 
 
 -----
#### Task 3: Loops
**Document with examples:**

**for loop — list-based and C-style**


The for loop is used to iterate over a list of items or numbers in Bash. There are two main styles:
 1️⃣ List-Based for Loop

Iterates over a list of words or items.

**Syntax**
for item in list
do
    commands
done

 2️⃣ C-Style for Loop

for (( initialization; condition; increment ))
do
    commands
done



**while loop**
The while loop is used to repeat a set of commands as long as a condition is true.
It is ideal when you don’t know in advance how many times you need to loop.

**Example**
while [ condition ]
do
    commands
done



**until loop**

The until loop is the opposite of a while loop.
It executes commands until a condition becomes true (i.e., it loops while the condition is false).

**Example**
until [ condition ]
do
    commands
done


**Loop control — break, continue**
- **break:**break immediately terminates the current loop, skipping all remaining iterations.

**Example**
  #!/bin/bash

  for i in {1..10}
  do
    if [ $i -eq 5 ]; then

      break   # exit loop when i = 5
    fi
    echo "Number: $i"
  done

- **continue:**continue skips the rest of the commands in the current iteration and moves to the next iteration.
**Example**

  #!/bin/bash

  for i in {1..5}
  do
    if [ $i -eq 3 ]; then

        continue   # skip when i = 3
    fi
    echo "Number: $i"
  done



####Looping over files — for file in *.log
In Bash, you can loop over files matching a pattern (like .log files) using a for loop. This is extremely useful in DevOps scripts for processing multiple files automatically.

**Example:**

 #!/bin/bash

 for file in *.log
 do
    echo "Found log file: $file"
 done



**Looping over command output — while read line**
In Bash, you can process the output of a command line by line using a while loop with read.
**Example:**
command | while read line
do
    commands
done

----


#### Task 4: Functions
**Document with examples:**

**Defining a function — function_name() { ... }**
Functions in Bash let you group a set of commands and reuse them multiple times in a script.They help make scripts modular, organized, and easier to maintain.
 **Example**
 
 #!/bin/bash

greet() {
    echo "Hello, DevOps!"
}

- [ ] #Call the function
 greet



**Calling a function**

Once a function is defined in Bash, calling it is simple — just use its name, optionally with arguments.

**Example:**
 #!/bin/bash

greet() {
    echo "Hello, DevOps!"
}

 #Call the function
greet




**Passing arguments to functions — $1, $2 
inside functions**

In Bash, functions can accept arguments just like scripts.
Inside the function, the arguments are accessed using positional parameters: $1, $2, $3, etc.

**Example**

 #!/bin/bash

greet() {
    echo "Hello, $1!"
    
    echo "You are from $2."
}


 #Call function with two arguments
greet ABC USA




**Return values — return vs echo**


In Bash, functions can provide results or status, but there’s an important distinction between return and echo.

 1️⃣ return — Exit Status

return sets the exit status of the function (integer between 0–255)

Commonly used to indicate success (0) or failure (non-zero)

Cannot return strings or numbers larger than 255

**Example:**

 #!/bin/bash
is_even() {
    if [ $(( $1 % 2 )) -eq 0 ]; then
        return 0    # success
    else
        return 1    # failure
    fi
}

is_even 8
echo "Exit status: $?"   # 0 → true

is_even 7
echo "Exit status: $?"   # 1 → false

**$?** → stores the exit status of the last command/function

 2️⃣ echo — Return Data / Output

echo outputs strings, numbers, or any data

You can capture the output using $(...) or backticks


**Example**

 #!/bin/bash

add() {
    sum=$(( $1 + $2 ))
   
    echo $sum    
}

result=$(add 5 7)  


echo "Sum is $result"




**Local variables — local**

In Bash, variables are global by default.
Using local inside a function makes the variable limited in scope to that function, avoiding conflicts with global variables.

**Example**
 #!/bin/bash

global_var="I am global"

my_func() {
    local local_var="I am local"
    echo "Inside function:"

    echo "local_var = $local_var"

    echo "global_var = $global_var"
}

my_func

echo "Outside function:"
echo "local_var = $local_var"   

echo "global_var = $global_var" 




-----
#### Task 5: Text Processing Commands
**Document the most useful flags/patterns for each:**

**grep — search patterns, -i, -r, -c, -n, -v, -E**

The grep command is used to search for patterns in files or input. It’s one of the most commonly used tools for text processing in Bash and DevOps scripting.

**syntax:**
grep [options] "pattern" file

**Table:**
| Option | Description                                                |   |
| ------ | ---------------------------------------------------------- | - |
| `-i`   | Ignore case (case-insensitive search)                      |   |
| `-r`   | Recursive — search in directories and subdirectories       |   |
| `-c`   | Count — shows the number of matching lines                 |   |
| `-n`   | Line number — shows matching line numbers                  |   |
| `-v`   | Invert match — shows lines that **do NOT match**           |   |
| `-E`   | Extended regex — allows advanced patterns like `+`, `?`, ` | ` |


**awk — print columns, field separator, patterns, BEGIN/END**
awk is a powerful text-processing tool in Bash for extracting and manipulating data from files or command output. It works line by line and field by field.

**Syntax:**
awk 'pattern { action }' file








**sed — substitution, delete lines, in-place edit**
sed (stream editor) is a powerful tool for text manipulation in Bash. You can replace text, delete lines, and edit files directly.

**Syntax:**
sed [options] 'command' file


**cut — extract columns by delimiter**

The cut command is used to extract specific fields (columns) from text based on a delimiter. It’s lightweight and commonly used for quick parsing of logs, CSVs, or command output.


**Syntax:**
cut -d 'DELIMITER' -f FIELDS file

**sort — alphabetical, numerical, reverse, unique**

The sort command is used to arrange lines in a file or command output in a specified order. It’s widely used in Bash scripting and DevOps for organizing data.

**Syntax:**
sort [options] file


**uniq — deduplicate, count**


The uniq command is used to remove duplicate lines or count occurrences of lines. It’s often used together with sort because uniq only removes consecutive duplicates.

**Syntax:**
uniq [options] file



**tr — translate/delete characters**

The tr command is used to translate, replace, or delete characters from input. It reads from stdin and writes to stdout, making it great for text preprocessing.

**Syntax:**

tr [options] SET1 [SET2]


**wc — line/word/char count**
The wc (word count) command counts lines, words, characters, or bytes in a file or input. It’s commonly used in Bash scripts for text analysis and reporting.

**Syntax:**
wc [options] file


**head / tail — first/last N lines, follow mode**

The head and tail commands are used to view parts of files or command output. They are essential for log analysis and quick file inspection in Bash/DevOps workflows.

**Syntax:**
- head [options] file

- tail [options] file

-----






#### Task 6: Useful Patterns and One-Liners
**Include at least 5 real-world one-liners you find useful. Examples:**

**Find and delete files older than N days**
**Syntax:**
find /path/to/directory -type f -mtime +N -exec rm -f {} \;

**Example:**

find /var/log -type f -mtime +30 -exec rm -f {} \;

- Deletes all files in /var/log older than 30 days


**Count lines in all .log files**
**Syntax:**
find /path/to/dir -type f -name "*.log" -exec wc -l {} +



**Replace a string across multiple files**
**Syntax:**
find /path/to/dir -type f -exec sed -i 's/old_string/new_string/g' {} +

**Check if a service is running**
1️⃣ Using systemctl (for systemd systems)

`systemctl status <service_name>`

2️⃣ Using service (older systems)
`service <service_name> status`


**Monitor disk usage with alerts**
Monitoring disk space is crucial in DevOps to prevent servers from running out of space. You can use df and Bash scripts to check usage and send alerts.
`df -h`


**Parse CSV or JSON from command line** Handling structured data like CSV or JSON is common, can be parse  using awk, cut, or specialized tools like jq for JSON.

**cut**
`cut -d ',' -f 1,3 file.csv`

-d ',' → delimiter is comma

-f 1,3 → extract columns 1 and 3
 **awk**
` awk -F',' '{print $1, $3}' data.csv`


**Tail a log and filter for errors in real time**

Monitoring logs as they happen is crucial to detect issues quickly. You can use tail -f combined with grep or awk to filter messages like errors.

`tail -f /var/log/syslog`

---
#### Task 7: Error Handling and Debugging
**Document with examples:**

**Exit codes — $?, exit 0, exit 1**

Every command in Linux returns an exit status (integer) when it finishes.

Standard convention:

0 → success

Non-zero → failure (different numbers can indicate different errors)

**Example:**
ls /tmp
echo "Exit code: $?"


**set -e — exit on error**

set -e is a safety feature in Bash scripts that tells the script to stop execution immediately if any command fails (returns a non-zero exit code). This is crucial in DevOps and automation to prevent scripts from continuing in a broken state.
**Example:**

 #!/bin/bash
set -e

echo "Step 1"
ls /tmp

echo "Step 2"
ls /nonexistent

echo "Step 3"
echo "This line will NOT run"


**set -u — treat unset variables as error**

set -u (or set -o nounset) is a Bash option that forces the script to exit when it encounters an unset or undefined variable. This is essential for preventing bugs caused by typos or missing environment variables in DevOps scripts.

**Example:**

 #!/bin/bash
set -u

echo "Value of VAR: $VAR"

**set -o pipefail — catch errors in pipes**

By default, in Bash, when you use a pipeline (|), the exit code of the pipeline is the exit code of the last command, even if an earlier command fails. This can hide errors.

set -o pipefail ensures that the pipeline fails if any command in it fails, making scripts safer and more reliable in DevOps automation.

**Example:**

 #!/bin/bash
set -e
set -o pipefail

false | true
echo "Pipeline finished with exit code $?"


**set -x — debug mode (trace execution)**

set -x enables debug mode in Bash, which prints each command before it is executed along with its arguments. This is extremely useful for debugging scripts in DevOps and automation.

**Syntax:**
 #!/bin/bash
set -x

echo "Step 1"
VAR="Hello"
echo "Value of VAR: $VAR"


**Trap — trap 'cleanup' EXIT**


The trap command lets a Bash script catch signals or exit events and execute a command or function in response. This is essential in DevOps scripts for cleanup, logging, or error handling.

**Syntax:**
trap 'command_to_run' SIGNALS

-----







