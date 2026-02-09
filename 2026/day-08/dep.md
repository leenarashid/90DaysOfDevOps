> # Cloud Server Setup: Docker, Nginx & Web Deployment
>## `Summary:` 
Today's task emphasizes  on launching the EC2 instance then connecting it through  SSH connection.Since I am working on Windows11, therefore I opted for GitBash.Installed a service and then collected the logs.
>## `Launching Of The Instance:`


<img src="1.png" width="900">

>## `SSH Connection:`
SSH connection has been established following the steps,using the downloaded .pem key of the instance.
<img src="cloud/2.png" width="600">

>## `NGINX Installation:` 
Nginx has been installed using `sudo apt-get update && sudo apt install nginx -y` command.The screenshot shows the installed verion on the instance.
<img src="cloud/3.png" width="600">

>## `Edit Inbound Rules:`
 Althoug nginx would work in side terminal but to make Nginx accessible from outside, there is a need to edit inbound rules,therefore added rule,from AnywhereIPV4 on Port-80.
 <img src="cloud/4.png" width="600">

>## `NGINX HTML Page:`
 Now the Nginx can be accessed from the browser
<img src="cloud/5.png" width="600">

<img src="cloud/6.png" width="600">

>## `NGINX Logs:`
 Nginx logs can be collected using  the command `journalctl -u <servicename>`
<img src="cloud/7.png" width="600">

>## `Log Collection:` 
This step involves the collection of logs and then saving it in a text file.This text file should be available locally on the system.
