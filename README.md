# MooseFS Docker Cluster

This is a sample MooseFS DEMO cluster on Docker containers using Debian Buster image.
After a successful installation you will have a fully functional MooseFS cluster to play with its amazing features.

# Updates

Fixes:
- fix problem with correct exit signals handling
- switch to persistant configuation. All metadata are now saved correctly.

Features:
- switched to *debian:buster* as base image
- chunk servers with labels (labels: M, MB, MB, B)
- separte CGI/cli container (python3)
- all moosefs example configuration files stored in data folder
- add mfscli to client container

# Cluster configurations

Cluster consists of:
- master server
- CGI server
- 4 chunk servers 
- client machine
- client with dd write operation

MooseFS network:
- 172.20.0.0/24

**File docker-compose.yml**

- mfsmaster **172.20.0.2**
- mfscgi **172.20.0.3** with exported port 9425, [http://localhost:9425](http://localhost:9425)
- chunkserver1 **172.20.0.11**, label: **M**
- chunkserver2 **172.20.0.12**, label: **M**,**B**
- chunkserver3 **172.20.0.13**, label: **M**,**B**
- chunkserver4 **172.20.0.14**, label: **B**
- client-writer **172.168.20.0.101**
- client **172.168.20.0.100**

# Setup

Install Docker with Docker Composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Clone MooseFS docker cluster repository:

```
git clone https://github.com/moosefs/moosefs-docker-cluster
cd moosefs-docker-cluster
```

Build and run:

```
docker-compose build
docker-compose up
```

To stop the MooseFS cluster just press ctrl+c key and wait for processes exit.

If you like you can run cluster in a background. Just add -d option to docker-compose up command:

```
docker-compose up -d
```

To stop MooseFS cluster started in a background execute this command:

```
docker-compose down
```

You can check if all containers are running by executing this command:

```
docker ps
```

There should be 6 containers running: 1 master, 4 chunkservers and 1 client running.
Expected command output should be similar to below list:

```
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS              PORTS                     NAMES
2567b644f727        moosefs-docker-cluster_mfscgi            "mfscgiserv -f"          26 minutes ago      Up 3 seconds        0.0.0.0:9425->9425/tcp    mfscgi
5f44ce206d70        moosefs-docker-cluster_mfsclient-write   "bash -c 'set -m ; m…"   32 minutes ago      Up 3 seconds                                  mfsclient-write
fa4039eec22a        moosefs-docker-cluster_mfsclient         "mfsmount -f -H mfsm…"   49 minutes ago      Up 3 seconds                                  mfsclient
dfcc24627591        moosefs-docker-cluster_mfschunkserver2   "mfschunkserver -f"      49 minutes ago      Up 4 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver2
e33a00e90382        moosefs-docker-cluster_mfschunkserver3   "mfschunkserver -f"      49 minutes ago      Up 3 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver3
0e3793cd67e1        moosefs-docker-cluster_mfschunkserver4   "mfschunkserver -f"      49 minutes ago      Up 3 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver4
e856184181b8        moosefs-docker-cluster_mfschunkserver1   "mfschunkserver -f"      49 minutes ago      Up 3 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver1
39158a3adf20        moosefs-docker-cluster_mfsmaster         "mfsmaster -f"           49 minutes ago      Up 5 seconds        9419-9422/tcp             mfsmaster
```

# Attach/detach to/from container

To **attach** to the client node execite this command:

```
docker exec -it mfsclient bash
```

To **detach** from container pres `Ctrl + d`.

Now MooseFS filesystem is mounted as `/mnt/moosefs`. If everything is ok you should see ASCII moose:

```
cat /mnt/moosefs/.mooseart
 \_\            /_/
    \_\_    _/_/
        \--/
        /OO\_--____
       (__)        )
        ``\    __  |
           ||-'  `||
           ||     ||
           ""     ""
```

# CGI

The MooseFS CGI web page is available in this location: [http://localhost:9425](http://localhost:9425) 
On Linux OS you can access MooseFS CGI directly from bridged network [http://172.20.0.3:9425](http://172.20.0.3:9425) (be aware of a local 172.20.0.* network).


![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/raw/master/images/cgi.png)

# Persistence

Your MooseFS Docker cluster is persistent. It means all files you created in the /mnt/moosefs folder will remain there even after turning containers off.
MooseFS disks are now mounted in host `./data` directory.

# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/chunkserver-client](https://hub.docker.com/r/moosefs/chunkserver-client/)  | [![chunkserver-client](https://img.shields.io/docker/pulls/moosefs/chunkserver-client.svg)](https://hub.docker.com/r/moosefs/chunkserver-client/)    | ![chunkserver-client](https://img.shields.io/docker/stars/moosefs/chunkserver-client.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver-client.svg) |

Scripts are based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster). Thank you Kai!
