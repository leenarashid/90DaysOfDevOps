>### **OSI**(Open Systems Interconnection Model)
------
The OSI model consists of 7-layers.
>#### Application Layer:
This is the `7th layer `of the model.User-facing services like web browsers and email.

>#### Presentation Layer:
`6th layer` of the model.Data formatting, encryption, and compression.

>#### Session Layer:
`5th layer` of the model.Manages communication sessions between devices.

>#### Transport Layer:
`4th layer` of the model.Ensures reliable data delivery (e.g., TCP/UDP).

>#### Network Layer:
`3rd layer` of the model.Handles routing and IP addressing.

>#### Data Link Layer:
`2nd layer` of the model.Transfers data between devices on the same network.

>#### Physical Layer:
`1st layer` of the model.Transmits raw bits through cables or wireless signals.

>### **TCP/IP Model**(Transmission Control Protocol / Internet Protocol)
----
This model comprises of four layers.


>#### Application Layer:
`4th layer` of the model.This layer is composed of (Application layer,Presentation layer and Session layer of the OSI model).Handles user-facing protocols like HTTP, FTP, SMTP.

>#### Transport Layer:
`3rd layer` of the model.Manages data delivery using TCP (reliable) or UDP (fast, connectionless).

>#### Internet Layer:
`2nd layer` of the model.Handles logical addressing and routing using IP.

>#### Network Access Layer:
`1st layer ` of the model. It has two layers of the OSI Model as a part (Data Link Layer and Physical Layer).

>### Where IP, TCP/UDP, HTTP/HTTPS, DNS sit in the stack?
-----
-  [ ] IP-> Internet Layer
- [ ] TCP/IP -> Transport Layer
- [ ] HTTP/HTTPS -> Application Layer
- [ ] DNS -> Network Access Layer

>#### Following table shows the step from "curling" a URL and the usecase of each OSI Layer.






| Step | Action          | Example                                  | Layer                        | Command                                                                        |
| ---- | --------------- | ---------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------ |
| 1    | Run curl        | `curl https://example.com`               | Application                  | `bash curl https://example.com`                                                |
| 2    | DNS lookup      | IP returned `93.184.216.34`              | Application                  | `bash nslookup example.com` <br>or <br>`bash dig example.com`                  |
| 3    | TCP handshake   | SYN/SYN-ACK/ACK to port 443              | Transport (TCP)              | `bash nc -vz example.com 443` <br>(or `telnet example.com 443`)                |
| 4    | TLS handshake   | Encrypt communication                    | Application (HTTPS)          | `bash openssl s_client -connect example.com:443`                               |
| 5    | HTTP GET        | `GET / HTTP/1.1`                         | Application (HTTPS)          | `bash curl -v https://example.com` <br>(`-v` shows request/response headers)   |
| 6    | TCP segments    | Split 1 KB request into 512-byte packets | Transport (TCP)              | `bash sudo tcpdump -i eth0 host example.com` <br>(shows TCP packets going out) |
| 7    | IP routing      | Packets travel across routers            | Network (IP)                 | `bash traceroute example.com` <br>(or `tracert example.com` on Windows)        |
| 8    | Server response | Homepage HTML returned                   | Application over TCP over IP | `bash curl https://example.com` <br>(or `wget https://example.com`)            |









>### Some Important Commands
-----
>#### Identity:


<img src="Screenshots/1.png" width="700">



>#### Reachability:


<img src="Screenshots/2.png" width="700">

>#### Path:

<img src="Screenshots/3.png" width="700">

>#### Ports:

<img src="Screenshots/4.png" width="700">

>#### Name resolution:

<img src="Screenshots/5-1.png" width="700">


<img src="Screenshots/5-2.png" width="700">

>#### HTTP check:


<img src="Screenshots/6.png" width="700">


>#### Connections snapshot: 


<img src="Screenshots/7.png" width="700">



>### Port Probe & Interpret


> #### Identify one listening port from ss -tulpn


<img src="Screenshots/8-1.png" width="700">

>#### From the same machine, test it: nc -zv localhost <port> 


<img src="Screenshots/8-2.png" width="700">

>#### Write one line: is it reachable? If not, what’s the next check? (e.g., service status, firewall).

Verify if the service is running (systemctl status <service>) and inspect firewall rules (ufw status or iptables -L).


>#### Which command gives you the fastest signal when something is broken?

- [ ] ping → Is host reachable?

- [ ] nslookup/dig → Is DNS working?

- [ ] nc -vz example.com 443 Is port open?

- [ ] curl -v https://example.com
 → Is application working?


>#### What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?

>#### Answer:
 If HTTP 500 shows up

Inspect the Application Layer (OSI Layer 7 / TCP-IP Application layer).

Why?
HTTP 500 = Internal Server Error → The server application (like Apache, Nginx, backend app) is failing.

This means:

Network connectivity is working

TCP connection succeeded

Server received the request

Application crashed or misbehaved


>#### Two follow-up checks you’d run in a real incident.

>#### Answer:
- [ ] systemctl status <service_name>
- [ ] journalctl logs <service_name>
- [ ] dig example.com @8.8.8.8
