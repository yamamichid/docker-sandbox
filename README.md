# docker-sandbox

## Build
Build image from Dockerfile
```sh
$ docker build -t hello:1.0 .
[+] Building 6.4s (7/7) FINISHED                                                                                                                                                                                   
 => [internal] load build definition from Dockerfile                                                                                                                                                          0.0s
 => => transferring dockerfile: 37B                                                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                                             0.0s
 => => transferring context: 2B                                                                                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                                                              6.4s
 => [internal] load build context                                                                                                                                                                             0.0s
 => => transferring context: 29B                                                                                                                                                                              0.0s
 => [1/2] FROM docker.io/library/ubuntu:latest@sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322                                                                                        0.0s
 => CACHED [2/2] COPY hello.sh ~/hello.sh                                                                                                                                                                     0.0s
 => exporting to image                                                                                                                                                                                        0.0s
 => => exporting layers                                                                                                                                                                                       0.0s
 => => writing image sha256:ff87b7a2ec4ac87516c4b8235d08118264b0058a3fef752a9a3c9eacc7b6bc3d                                                                                                                  0.0s
 => => naming to docker.io/library/hello:1.0
```

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED         SIZE
hello                             1.0       ff87b7a2ec4a   2 minutes ago   72.8M
```

## Create
Create container from image
```sh
$ docker create hello:1.0
14b465d2568c13d4a423ceccaabe8d60d0884f0f21012bde37d728533816eda
```

```sh
$ docker ps -f status=created
CONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS    PORTS     NAMES
14b465d2568c   hello:1.0   "/bin/bash ~/hello.sh"   2 minutes ago   Created             goofy_shtern
```

## Start
Start container

- By ID
    - Start
        ```sh
        $ docker start 14b465d2568c13d4a423ceccaabe8d60d0884f0f21012bde37d728533816eda 
        14b465d2568c13d4a423ceccaabe8d60d0884f0f21012bde37d728533816eda
        ```
    - Start With attach
        ```sh
        $ docker start --attach 14b465d2568c13d4a423ceccaabe8d60d0884f0f21012bde37d728533816eda
        Hello World!
        ```
- By name
    - Start
        ```sh
        $ docker start goofy_shtern
        14b465d2568c13d4a423ceccaabe8d60d0884f0f21012bde37d728533816eda
        ```
    - Start With attach
        ```sh
        $ docker start --attach goofy_shtern
        Hello World!
        ```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS                          PORTS     NAMES
14b465d2568c   hello:1.0         "/bin/bash ~/hello.sh"   4 minutes ago   Exited (0) About a minute ago             goofy_shtern
```

## Remove
Remove container
```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS                      PORTS     NAMES
f6cf5e0f62a1   hello:1.0         "/bin/bash ~/hello.sh"   6 minutes ago   Exited (0) 3 minutes ago              goofy_shtern
```
```sh
$ docker rm goofy_shtern
goofy_shtern
```
```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED      STATUS                      PORTS     NAMES
$ docker ps -f status=created
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

## Run
Create and Start container

```sh
$ docker run --attach STDOUT hello:1.0
Hello World!
```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS                      PORTS     NAMES
e2b12b567b62   hello:1.0         "/bin/bash ~/hello.sh"   19 seconds ago   Exited (0) 19 seconds ago             suspicious_hamilton
```

```sh
$ docker run --attach STDOUT suspicious_hamilton
Unable to find image 'suspicious_hamilton:latest' locally
docker: Error response from daemon: pull access denied for suspicious_hamilton, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'
```

```sh
$ docker run --attach STDOUT hello:1.0
Hello World!
```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS                          PORTS     NAMES
042bd1c31d5d   hello:1.0         "/bin/bash ~/hello.sh"   12 seconds ago       Exited (0) 11 seconds ago                 focused_pascal
e2b12b567b62   hello:1.0         "/bin/bash ~/hello.sh"   About a minute ago   Exited (0) About a minute ago             suspicious_hamilton
```

## Stop
Stop(Exit) container

```sh
$ docker build -f StopDockerfile -t stop:1.0 .
[+] Building 6.4s (6/6) FINISHED                                                                                                                                                                                   
 => [internal] load build definition from StopDockerfile                                                                                                                                                      0.0s
 => => transferring dockerfile: 41B                                                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                                             0.0s
 => => transferring context: 2B                                                                                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                                                              6.4s
 => [1/2] FROM docker.io/library/ubuntu:latest@sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322                                                                                        0.0s
 => CACHED [2/2] RUN echo Stop example                                                                                                                                                                        0.0s
 => exporting to image                                                                                                                                                                                        0.0s
 => => exporting layers                                                                                                                                                                                       0.0s
 => => writing image sha256:ee36938dad22233685aaabc8256a2843c0784b8b9f9d3c27fae5c29d949d0f9e                                                                                                                  0.0s
 => => naming to docker.io/library/stop:1.0
```

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED              SIZE
stop                              1.0       ee36938dad22   About a minute ago   72.8MB
```

```sh
$ docker run stop:1.0

```

Open new terminal

```sh
$ docker ps -f status=running
CONTAINER ID   IMAGE      COMMAND            CREATED          STATUS          PORTS     NAMES
baab2b7253e9   stop:1.0   "sleep infinity"   39 seconds ago   Up 38 seconds             gallant_kare
```

```sh
$ docker stop gallant_kare
gallant_kare
```

```sh
$ docker ps -f status=running
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS                            PORTS     NAMES
baab2b7253e9   stop:1.0          "sleep infinity"         2 minutes ago    Exited (137) About a minute ago             gallant_kare
```

## Pause
Pause container

```sh
$ docker ps -f status=paused
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```sh
$ docker run stop:1.0

```

Open new terminal

```sh
$ docker ps
CONTAINER ID   IMAGE      COMMAND            CREATED          STATUS          PORTS     NAMES
a8310b1f7b84   stop:1.0   "sleep infinity"   40 seconds ago   Up 39 seconds             inspiring_chaplygin
```

```sh
$ docker pause inspiring_chaplygin
inspiring_chaplygin
```

```sh
$ docker ps -f status=paused
CONTAINER ID   IMAGE      COMMAND            CREATED              STATUS                       PORTS     NAMES
a8310b1f7b84   stop:1.0   "sleep infinity"   About a minute ago   Up About a minute (Paused)             inspiring_chaplygin
```
## Unpause
Unpause container

```sh
$ docker unpause inspiring_chaplygin
inspiring_chaplygin
```

```sh
$ docker ps
CONTAINER ID   IMAGE      COMMAND            CREATED              STATUS              PORTS     NAMES
a8310b1f7b84   stop:1.0   "sleep infinity"   About a minute ago   Up About a minute             inspiring_chaplygin
```

## Remove image
Remove image

```sh
$ docker ps --all
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS                        PORTS     NAMES
a8310b1f7b84   stop:1.0          "sleep infinity"         4 minutes ago    Up 4 minutes                            inspiring_chaplygin
baab2b7253e9   stop:1.0          "sleep infinity"         10 minutes ago   Exited (137) 7 minutes ago              gallant_kare
042bd1c31d5d   hello:1.0         "/bin/bash ~/hello.sh"   20 minutes ago   Exited (0) 20 minutes ago               focused_pascal
e2b12b567b62   hello:1.0         "/bin/bash ~/hello.sh"   21 minutes ago   Exited (0) 21 minutes ago               suspicious_hamilton
```

```sh
$ docker rm inspiring_chaplygin
inspiring_chaplygin
$ docker rm gallant_kare
gallant_kare
$ docker rm focused_pascal
focused_pascal
$ docker rm suspicious_hamilton
suspicious_hamilton
```

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED          SIZE
stop                              1.0       5684fe2e8c8b   12 minutes ago   72.8MB
hello                             1.0       ff87b7a2ec4a   41 minutes ago   72.8MB
```

```sh
$ docker image rm stop:1.0
Untagged: stop:1.0
Deleted: sha256:5684fe2e8c8b8bcd015854cce19c094c9fcc640654ba5b453f59b6d06556ae99
```

```sh
$ docker image rm hello:1.0
Untagged: hello:1.0
Deleted: sha256:ff87b7a2ec4ac87516c4b8235d08118264b0058a3fef752a9a3c9eacc7b6bc3d
```

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED          SIZE
```

## Exec
```sh
$ docker run stop:1.0

```
Open new terminal

```sh
$ docker ps
CONTAINER ID   IMAGE      COMMAND            CREATED          STATUS          PORTS     NAMES
f8eda05e46e9   stop:1.0   "sleep infinity"   36 seconds ago   Up 35 seconds             friendly_lamport
```

```bash
$ docker exec -it friendly_lamport /bin/bash
root@f8eda05e46e9:/# 
```

```sh
root@f8eda05e46e9:/# exit
exit
$ 
```


# Docker compose

## up
Build image and Create Network and Create container and Start container.

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED        SIZE
```

```sh
 docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED          SIZE
docker-sandbox_hello              latest    ff87b7a2ec4a   54 minutes ago   72.8MB
```

```sh
$ docker compose up
[+] Building 8.8s (8/8) FINISHED                                                                                                                                                    
 => [internal] load build definition from Dockerfile                                                                                                                           0.0s
 => => transferring dockerfile: 115B                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                              0.0s
 => => transferring context: 2B                                                                                                                                                0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                               8.4s
 => [auth] library/ubuntu:pull token for registry-1.docker.io                                                                                                                  0.0s
 => [internal] load build context                                                                                                                                              0.3s
 => => transferring context: 52B                                                                                                                                               0.3s
 => [1/2] FROM docker.io/library/ubuntu:latest@sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322                                                         0.0s
 => CACHED [2/2] COPY hello.sh ~/hello.sh                                                                                                                                      0.0s
 => exporting to image                                                                                                                                                         0.0s
 => => exporting layers                                                                                                                                                        0.0s
 => => writing image sha256:ff87b7a2ec4ac87516c4b8235d08118264b0058a3fef752a9a3c9eacc7b6bc3d                                                                                   0.0s
 => => naming to docker.io/library/docker-sandbox_hello                                                                                                                        0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
[+] Running 2/2
 ⠿ Network docker-sandbox_default    Created                                                                                                                                   0.0s
 ⠿ Container docker-sandbox-hello-1  Created                                                                                                                                   0.1s
Attaching to docker-sandbox-hello-1
docker-sandbox-hello-1  | Hello World!
docker-sandbox-hello-1 exited with code 0
```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS                          PORTS     NAMES
d20017912acd   docker-sandbox_hello   "/bin/bash ~/hello.sh"   About a minute ago   Exited (0) About a minute ago             docker-sandbox-hello-1
```

```sh
$ docker network ls
NETWORK ID     NAME                     DRIVER    SCOPE
22c8b3398ca3   host                     host      local
07779025b041   docker-sandbox_default   bridge    local
```

## down
Stop container and Remove container and Remove Network.
```sh
$ docker compose down
[+] Running 2/2
 ⠿ Container docker-sandbox-hello-1  Removed                                                                                                                                   1.0s
 ⠿ Network docker-sandbox_default    Removed
```

```sh
$ docker ps -f status=exited
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS                        PORTS     NAMES
```


```sh
$ docker network ls
NETWORK ID     NAME             DRIVER    SCOPE
22c8b3398ca3   host             host      local
```

```sh
$ docker image ls
REPOSITORY                        TAG       IMAGE ID       CREATED          SIZE
docker-sandbox_hello              latest    ff87b7a2ec4a   55 minutes ago   72.8MB
```
