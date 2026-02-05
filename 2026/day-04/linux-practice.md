>## Process Check Commands:
------
- #### `ps:` Displays the current processes (of the terminal you are in).


- #### `ps -a:` Displays all the terminal-associated processes.
- #### `ps aux:` Displays all processes with details.

- #### ` top:` Displays real-time process monitoring.
- #### `ps aux | grep top:` It will display the process (top) detils along with PID.
- #### `kill PID(top):`Stops the process (top), will not be displayed by ps command.
- #### `kill -9 PID:` Vanishes the stopped process completely.
- #### `pgrep <process_name>:` Searches for the process by name.
- #### `<process_name> &:`Runs the process in the background.
>## Service Check Commands:

- #### `sudo systemctl start docker:` Starts the docker service, immediately
- #### `sudo systemctl status docker:` Checks whether the docker is active (running) or not.
- #### `sudo systemctl stop docker:` Stops the docker service.
- #### `sudo systemctl enable docker:` Configures the docker service automatically at the boot time.
- #### `sudo systemctl disable docker:` Stops the docker service from starting automatically at system boot.
- #### `sudo systemctl list-units-files | grep docker:` Shows all installed Docker-related systemd units and their startup status (enabled, disabled, static, etc.). grep docker filters the output to only show Docker services.

>## Log Check Commands:

- #### `journalctl:` Allows to view all system logs, restricted to the permitted logs only.

- #### ` sudo journalctl:` Shows all system-wide logs, including services, kernel messages, and other users’ logs.

- #### `journalctl -xe:` Shows recent system logs with extra detail and error explanations.

- #### `sudo journalctl -xe:` Shows recent system logs and errors with extra explanations, in real-time context, requiring root access.

- #### `journalctl -u :` Shows the logs for a specific systemd service.

- #### `journalctl -u --since "1 hour ago":`Shows logs for a specific service from the last 1 hour.

- #### ` tail -n 50 /var/log/syslog:` Displays last 50 system logs.

- #### ` tail -n 50 /var/log/auth.log: `Displays the last 50 lines of the authentication log.

- #### `tail -n 50 /var/log/dmesg:`Displays the last 50 lines of the kernel log messages.
