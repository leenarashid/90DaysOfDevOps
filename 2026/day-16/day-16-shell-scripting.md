>### **SHELL SCRIPTING BASICS**
----
>#### TASK1: FIRST SCRIPT
- Create a file hello.sh
- Add the shebang line #!/bin/bash at the top.
- Print Hello, DevOps! using echo
- Make it executable and run it

> **[ Script](scripts/hello.sh)**


>**Output**
<img src="images/output1.png" width="900">




> #### TASK2: Variables
- Create variables.sh with:
- [ ] A variable for your NAME
- [ ] A variable for your ROLE (e.g., "DevOps Engineer")
- [ ] Print: Hello, I am NAME and I am ROLE.
> **[ Script](scripts/variable.sh)**

> **Output**
<img src="images/output2.png" width="900">


> #### TASK3: User Input with read
- Create greet.sh that:
- [ ] Asks the user for their name using read
- [ ] Asks for their favourite tool
- [ ] Prints: Hello <name>, your favourite tool is tool
> **[ Script](scripts/greet.sh)**

> **Output**

<img src="images/output3.png" width="900">



> #### TASK4: If-Else Conditions
- Create check_number.sh that:

- [ ] Takes a number using read
- [ ] Prints whether it is positive, negative, or zero


> **[ Script](scripts/check_number.sh)**



<img src="images/4-1.png" width="900">



- Create file_check.sh that:

- [ ] Asks for a filename
- [ ] Checks if the file exists using -f
- [ ] Prints appropriate message

> **[ Script](scripts/file_check.sh)**



<img src="images/4-2.png" width="900">


 > #### TASK5: Combine It All
- Create server_check.sh that:

- Stores a service name in a variable (e.g., nginx, sshd)
- Asks the user: "Do you want to check the status? (y/n)"
- If y — runs systemctl status <service> and prints whether it's active or not
- If n — prints "Skipped."


> **[ Script](scripts/server_check.sh)**

<img src="images/5-1.png" width="900">

<img src="images/5-2.png" width="900">



>### INTERVIEW QUESTIONS
------
> **Question**

 What happens if you remove the shebang line? **(TASK1)**
> **Answer**


It can work without SHEBANG,as bash shell is the default shell,
can be executed with bash or ./,either ways
comment

> **Question**

 Try using single quotes vs double quotes — what's the difference? **(TASK2)**
> **Answer**

Single quotes print text exactly as written, while double quotes allow variables and special characters to be interpreted.
