
>## Task1
----
> ### Definition And Features Of DNS:
-----
#### DNS (Domain Name System) is like the phonebook of the internet.

- It translates a human-readable domain name (like google.com) into a machine-readable IP address (like 142.250.190.14) so your computer knows where to connect.
- Computers communicate using IP addresses, not names.But humans remember names better than numbers.User just enters the name instead of the whole IP address and is redirected to the site.
- `nslookup` google.com give the IP address of google.
- DNS works at the Application Layer.

> ### What happens when you type google.com in a browser?
-----
- When any URL for instance google.com is typed,it is searched in the local cache.
- If not found there, The ISP (Internet Service Provider) queries the DNS resolver.(A DNS Resolver is a server that helps convert a website name into its IP address.)
- The resolver contacts root → TLD → authoritative DNS servers to get the IP address.(A TLD is the abbreviation of Top Level Domain, the last part of URL like `.com` , `.org`).
-Once the IP is returned, your browser connects to that IP using TCP/HTTPS and loads the website.

> ### DNS Record Types (One Line Each + Example)
------
**A Record** – Maps a domain name to an IPv4 address.
> Example: google.com → 142.250.190.14

**AAAA Record** – Maps a domain name to an IPv6 address.
> Example: google.com → 2607:f8b0:4007:80a::200e

**CNAME Record** – Points one domain name to another domain name (alias).
> Example: www.google.com → google.com

**MX Record** – Specifies the mail server responsible for receiving emails for a domain.
> Example: google.com → aspmx.l.google.com

**NS Record** – Defines the authoritative name servers for a domain.
> Example: google.com → ns1.google.com


> ### Run: dig google.com — identify the A record and TTL from the output

<img src="images/1.png" width="900">

> ## Task2
-----
> ### What is an IPv4 Address?
An IPv4 (Internet Protocol version 4) address is a 32-bit numeric address used to uniquely identify a device on a network.

> ### Structure of IPv4

- Written in dotted decimal format

- Contains 4 octets

- Each octet ranges from 0–255

- Total size = 32 bits (8 bits × 4)

>### Example
 **192   .   168   .   1   .   10**

**8 bits   8 bits   8 bits   8 bits**

#### It has:

- Network portion → Identifies the network

- Host portion → Identifies the device within that network


>### Difference Between Public and Private IPs

#### Public IP

- Accessible over the internet

- Assigned by an ISP

- Globally unique

✅ Example: 8.8.8.8


#### Private IP

- Used inside local/private networks

- Not directly accessible from the internet

- Used in homes, offices, cloud VPCs

✅ Example: 192.168.1.10


> #### Private IPv4 Ranges

| Range                           | Format                  |
| ------------------------------- | ----------------------- |
| `10.0.0.0 – 10.255.255.255`     | 10.x.x.x                |
| `172.16.0.0 – 172.31.255.255`   | 172.16.x.x – 172.31.x.x |
| `192.168.0.0 – 192.168.255.255` | 192.168.x.x             |

> #### Run: ip addr show — identify which of your IPs are private
<img src="images/2-1.png" width="900">


- **127.0.0.1/8** – Loopback address
- Private - 
- Used inside your machine only

- **172.31.14.27/20** – Network interface enX0
- Private
- Falls in the private range 172.16.0.0 – 172.31.255.255 (RFC 1918)
- Can be seen the one alloted by AWS.

> ## Task3
----
#### Why Do We Subnet?


- Reduce broadcast traffic

- Improve network performance

- Better security (separate departments)

- Efficient IP address usage

- Easier network management


> #### Some notes for ellaboration of IP adress ranges, number of useful hosts,subnet masks and hosts per subnet.




> ## Task4 
-----
>#### Ports – The Doors to Services

#### What is a port? 
A port is a logical endpoint in a computer or network device that allows multiple applications or services to use the same IP address without interfering with each other.

- **IP address** → identifies the device

- **Port**→ identifies the specific service or application on that device

**Example:**       **192.168.1.10:80**
- 192.168.1.10 → device IP

- 80 → port for HTTP web traffic

####  Why Do We Need Ports?

- Multiple Services on One Device

- Direct Traffic to the Correct Application
- Network Organization & Security


#### Important Ports

**22** ---- SSH
**80**	---- HTTP
**443** ---- HTTPS
**53**	---- DNS
**3306** ---- MYSQL
**6379** ---- Redis
**27017** ---- MongoDB

#### Run ss -tulpn — match at least 2 listening ports to their services
<img src="images/3.png" width="900">


> ## Task4

 #### You run curl http://myapp.com:8080 — what networking concepts from today are involved?
Running curl http://myapp.com:8080 involves 
1️⃣ DNS resolution (domain → IP)
2️⃣Then a TCP connection to the server’s IP on port 8080. 
3️⃣After the TCP handshake, an HTTP request is sent and the     server responds with data.

#### Your app can't reach a database at 10.0.1.50:3306 — what would you check first?


1️⃣ Network connectivity
2️⃣ Port accessibility
3️⃣ Database service
4️⃣ Firewall / Security Groups
