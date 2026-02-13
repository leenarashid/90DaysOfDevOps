> # `Day 12 – Breather & Revision `

> ## `Which 3 commands save you the most time right now, and why?`

1️⃣ **ps:** This command with flags -a or ps aux | grep <PID> is mainly used these days. It lists up all the processes, adding "-a" displays all the active processes and with the "grep" it fetches the processes with speecific id.

2️⃣**systemctl status <service_name> :** This command is used to check the status of the service (docker,nginx,sshd),whether active,stopped or paused.

 3️⃣**systemctl enable <service_name>:** A very useful command used to configure a service to start automatically at system boot.

4️⃣**top:** Displays the list of the processes along with PIDs and resource usage.










> ## `How do you check if a service is healthy?`

1️⃣**uptime:** It tells you how long a system has been working continuously without crashing or shutting down.



2️⃣**systectl status <service_name>:** Is a command in Linux (using systemd) that shows the current status of a specific service.


3️⃣**journalctl -u <service>:** This command is used in Linux systems with systemd to view logs of a specific service.



> ## `How do you safely change ownership and permissions without breaking access?` 

1️⃣**ls -l:** Lists up all the files and with -d, all the directories along with the permissions and owner nad group.


2️⃣**sudo chown -R <new_owner>:<new_group> <file/dir_name>:** Helps to change the ownership recursively or a directory and file in one command .

3️⃣**sudo chmod -R u=rw,g=r,o= <file_name>:** Helps in changing permissions safely.-R for recusive action, affects the permissions down to the whole tree.
