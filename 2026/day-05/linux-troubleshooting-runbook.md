># ENVIRONMENT BASICS:
- #### `uname -a:` Displays detailed system information about your Linux machine in one line.


<img src="Task5/Task5-02.png" width="1100">



- #### `lsb_release -a:`Displays detailed information about the Linux distribution installed on your system.

<img src="Task5/Task5-03.png" width="500">

># FILESYSTEM SANITY:
- #### `mkdir /tmp/runbook-demo:` Creates a file runbook-demo in /tmp directory and can be viewed by ls.
<img src="Task5/Task5-04.png" width="900">

- #### `cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo:` Copies the contents of hosts (which is in /etc) to hosts-copy which is in runbook-demo inside /tmp.
<img src="Task5/Task5-05.png" width="1100">

- #### `ls -l:`shows the permissions of runbook-demo.


># CPU/MEMORY:

- #### ` top:` Displays real-time system information including CPU, memory, and running processes.
<img src="Task5/Task5-06.png" width="1100">

- #### `free -h:` Shows system memory usage in a human-readable format (RAM and swap).

<img src="Task5/Task5-07.png" width="1100">

># DISK/IO:

- #### `df -h:` Shows disk space usage for all mounted filesystems in a human-readable format (GB, MB).
<img src="Task5/Task5-08.png" width="500">

- #### `du -sh /var/log:` Shows the total disk space used by the /var/log directory in a human-readable format.
<img src="Task5/Task5-09.png" width="500">

># NETWORK:
- #### ` ss -tulpn:`Shows all listening sockets (TCP/UDP) on your Linux system with process info and ports.Useful for troubleshooting.
<img src="Task5/Task5-10.png" width="1100">

- #### ` curl -I :` http://localhost:5000/ping: {ERROR}

> # LOGS:
- #### ` journalctl -u <service> -n 50:` In performed the tasks on docker.Shows the last 50 log entries for the Docker service from the system journal. Useful for quickly checking recent Docker activity or errors.
<img src="Task5/Task5-11.png" width="1100">

- #### `tail -n 50 /var/log/kern.log:` Shows the last 50 lines of the kernel log file (kern.log).Contains messages from the Linux kernel, including hardware events, driver messages, and system errors.

<img src="Task5/Task5(12).png" width="1100">

># IF IT WORSENS:
- #### `Restart Policy:`Planning how to safely restart a service or process when it misbehaves, (sudo systemctl restart docker)  

- #### `Increase Log Verbosity:`Make the service write more detailed logs for troubleshooting, (sudo dockerd --log-level debug)

- #### `Collect strace:` strace is a tool to trace system calls a process makes,(sudo strace -p <docker-pid>)
