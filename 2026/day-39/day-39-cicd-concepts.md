## Day 39 – What is CI/CD?

### Task 1: The Problem
#### Think about a team of 5 developers all pushing code to the same repo manually deploying to production.


#### What can go wrong?
**Answer:**
- Code conflicts between developers

-  One developer overwriting another’s changes

 -  Deploying the wrong version or branch

 -  Missing dependencies or configuration issues

- Human errors during manual deployment

-  Bugs reaching production due to lack of automated testing

- Application downtime if deployment fails











####  What does "it works on my machine" mean and why is it a real problem?


- Code works on a developer’s local computer but fails in another environment.

-  Happens because environments are different (OS, dependencies, configurations).

-  Causes unexpected bugs when code runs on staging or production servers.

-  Makes debugging difficult and slows down team productivity.


#### How many times a day can a team safely deploy manually?
- Usually 1–2 times per day at most.

-  Manual deployments take time and coordination.

- Higher frequency increases the risk of mistakes and downtime.


### Task 2: CI vs CD
#### Research and write short definitions (2-3 lines each).Also write one real-world example for each.
#### Continuous Integration — what happens, how often, what it catches

####Continuous Integration (CI) 

**Definition:**
Developers frequently merge code into a shared repository, usually multiple times a day. Automated builds and tests run on each merge to catch bugs, integration issues, or conflicts early.

**Example:**

GitHub runs CI on every pull request to ensure new code doesn’t break existing features.

#### Continuous Delivery — how it's different from CI, what "delivery" means
#### Continuous Delivery (CD — Delivery)

**Definition:**
Extends CI by automatically preparing code for release to production. “Delivery” means the code is always in a deployable state, but a human still approves the deployment.

**Example:**

Spotify uses Continuous Delivery to keep updates ready for release at any time, but releases are triggered manually.


#### Continuous Deployment — how it differs from Delivery, when teams use it

#### Continuous Deployment (CD — Deployment)

**Definition:**
Takes Continuous Delivery one step further: every change that passes automated tests is automatically deployed to production without human approval. Teams use it for fast, frequent releases.

**Example:**

Netflix deploys hundreds of updates daily automatically using Continuous Deployment.


#### Task 3: Pipeline Anatomy
#### A pipeline has these parts — write what each one does:

>**Trigger** — what starts the pipeline

**Definition:** What starts the pipeline automatically or manually.

>**Stage** — a logical phase (build, test, deploy)

**Definition:** A logical phase in the pipeline that groups related jobs, like build, test, or deploy.

>**Job** — a unit of work inside a stage

**Definition:** A unit of work inside a stage; a set of steps executed together.


>**Step** — a single command or action inside a job

**Definition:** A single command or action inside a job.

>**Runner** — the machine that executes the job

**Definition:** The machine (virtual or physical) that executes the jobs.


>**Artifact** — output produced by a job

**Definition:** Output produced by a job that can be used by other jobs or stored.

#### Task 5: Explore in the Wild
#### Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
#### Find their .github/workflows/ folder
#### Open one workflow YAML file
#### Write in your notes:
#### What triggers it?
#### How many jobs does it have?
####What does it do? (best guess)

**Workflow**
name: FastAPI CI Pipeline

>>Following is the trigger for main branch whenever commit is made workflow will be triggered.

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

>>This part defines jobs which will be run on runner: ubuntu that helps the job to get completed.

jobs:
  test-fastapi:
    runs-on: ubuntu-latest
>>Services define containers along with the environment variables, necessary to communicate with the other containers.
    
    
    services:
      mysql:
        image: mysql:8
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: fastapi_db
          MYSQL_USER: fastapi_user
          MYSQL_PASSWORD: fastapi_pass
        ports:
          - 3306:3306
        options: >-
          --health-cmd="mysqladmin ping --silent"
          --health-interval=10s
          --health-timeout=5s
          --health-retries=3

    env:
      DB_HOST: 127.0.0.1
      DB_PORT: 3306
      DB_USER: fastapi_user
      DB_PASSWORD: fastapi_pass
      SECRET_KEY: ${{ secrets.SECRET_KEY }}
      API_TOKEN: ${{ secrets.API_TOKEN }}
>> Steps are the essential parts of a job,responsible to perform divided tasks,which a job does collectively . 
    
    
    steps:
>> Cloning the user-space.
      - name: Checkout repository
        uses: actions/checkout@v4
>> Setting up Python.
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"
>> Installing dependencies.
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install fastapi uvicorn pytest mysql-connector-python sqlalchemy
>>Waiting for database cnatiner to respond.
      - name: Wait for MySQL
        run: |
          sudo apt-get install -y mysql-client
          until mysqladmin ping -h "127.0.0.1" --silent; do
            echo "Waiting for MySQL..."
            sleep 5
          done
>> Running various operations and tests on database.
      - name: Run database migrations
        run: |
          echo "Running migrations"

      - name: Run tests
        run: |
          pytest

      - name: Build FastAPI app
        run: |
          echo "Build successful"


