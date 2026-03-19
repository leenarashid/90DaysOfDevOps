### Day 37 – Docker Revision & Cheat Sheet
----
#### Task:1
#### Self-Assessment Checklist
- Mark yourself honestly — can do, shaky, or haven't done:

- [x] Run a container from Docker Hub (interactive + detached)
- [x]   List, stop, remove containers and images
- [x] Explain image layers and how caching works
- [x]  Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [x] Explain CMD vs ENTRYPOINT
- [x] Build and tag a custom image
- [x] Create and use named volumes
- [x] Use bind mounts
- [x] Create custom networks and connect containers
- [x] Write a docker-compose.yml for a multi-container app
- [x] Use environment variables and .env files in Compose
- [x] Write a multi-stage Dockerfile
- [x] Push an image to Docker Hub
- [x] Use healthchecks and depends_on


-----
#### Task2
#### Quick-Fire Questions

> What is the difference between an image and a container?
**Answer**

>**Docker Image**

Definition: A Docker image is a read-only template that contains everything needed to run an application: code, runtime, libraries, environment variables, and configuration files.
>**Characteristics:**
- Static and immutable.

- Can be versioned using tags (e.g., node:18-alpine).

- Stored in a registry like Docker Hub or locally. 




>What happens to data inside a container when you remove it?

>**Docker Container**

Definition: A container is a running instance of an image. It’s an isolated environment where the application actually runs.

>**Characteristics:**


- Mutable while running (can create/modify files inside it, but changes vanish unless saved in volumes or a new image).

- Has its own filesystem, networking, and process space.

- Can be started, stopped, paused, or deleted.








> How do two containers on the same custom network communicate?

**Answer:**

Two containers on the same custom Docker network communicate using each other’s container names as hostnames, because Docker provides internal DNS that resolves names to IPs within that network. No external ports are needed.





> What does docker compose down -v do differently from docker compose down?

Docker compose down stops and removes containers and networks; docker compose down -v also removes all associated volumes, deleting stored data.

> Why are multi-stage builds useful?

- Multi-stage builds are useful because they let you separate the build environment from the runtime environment, which:

- Reduces final image size – only copies what’s needed to run the app.

- Improves security – build tools and sensitive files don’t end up in the runtime image.

- Keeps images clean and efficient – fewer layers, no unnecessary dependencies.

> What is the difference between COPY and ADD?

The difference between COPY and ADD in Docker is about functionality:

**COPY**

- Simply copies files or directories from the host into the image.

- Straightforward, predictable, and recommended for most use cases.

**ADD**

- Can do everything COPY does plus:

- Automatically extracts local tar archives into the image.

- Can fetch files from remote URLs.



> What does -p 8080:80 mean?

**Answer**
In Docker, -p 8080:80 means:

8080 → port on your host machine

80 → port inside the container

It maps host port 8080 to container port 80, so accessing localhost:8080 on your computer sends traffic to port 80 in the container.


> How do you check how much disk space Docker is using?

**Answer**
docker system df

It shows:

- Images – space taken by images

- Containers – space taken by stopped and running containers

- Volumes – space used by Docker volumes

- Build cache – space used by build layers

----

#### Task3 
#### Create docker-cheatsheet.md organized by category:

**Container commands — run, ps, stop, rm, exec, logs**

`docker run`	Create and start a new container from an image
`docker ps`	List running containers
`docker stop`	Stop a running container gracefully
`docker rm`	Remove a stopped container
`docker exec`	Run a command inside a running container
`docker logs`	View logs from a container

**Image commands — build, pull, push, tag, ls, rm**


`docker build`	Build an image from a Dockerfile
`docker pull`	Download an image from a registry
`docker push`	Upload an image to a registry
`docker tag`	Assign a new name/tag to an image
`docker images` (ls)	List all local images
`docker rmi (rm)`	Remove an image from local system




**Volume commands — create, ls, inspect, rm**

`docker volume create`	Create a new named volume
`docker volume ls`	List all volumes
`docker volume inspect`	Get detailed info about a volume
`docker volume rm`	Remove a volume

**Network commands — create, ls, inspect, connect**



`docker network create`	Create a new Docker network
`docker network ls`	List all networks

`docker network inspect`	Show details of a network
`docker network connect`	Connect a container to a network


**Compose commands — up, down, ps, logs, build**

`docker compose up`	Build (if needed) and start all services
`docker compose down`	Stop and remove containers, networks, volumes (optional)
`docker compose ps`	List running services
`docker compose logs`	View logs from all or specific service
`docker compose build`	Build images defined in Compose file




**Cleanup commands — prune, system df**


`docker system prune`	Remove stopped containers, unused images, networks
`docker system df`	Show disk usage of Docker images, containers, volumes

**Dockerfile instructions — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT**



`FROM`	Base image to start from


`RUN`	Execute a command inside the image during build


`COPY`	Copy files from host into the image

`WORKDIR`	Set working directory for subsequent commands
`EXPOSE`	Declare the port the container listens on
`CMD`	Default command to run when container starts (can be overridden)
`ENTRYPOINT`	Set fixed command to run when container starts