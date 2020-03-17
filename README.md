# [eafxx/traktarr](https://hub.docker.com/r/eafxx/traktarr)

- Multiarch Support: 
  * amd64
  * armv7, arm64 i.e. supports Raspberry Pi
- Run commands configured via variables
- PUID/PGID support
- Updates app on container restart (can disable)

---

- [Requirements](#requirements)
- [Installation](#installation)
	- [Docker](#1-base-install-docker)
- [App Configuration](#configuration)

---


# Requirements

1. Trakt account

2. Trakt application (see instructions below)

3. Configure Arr apps

# Installation

## Docker

**Tags**

| Tag      | Description                          | Build Status                                                                                                | 
| ---------|--------------------------------------|-------------------------------------------------------------------------------------------------------------|
| latest | master/stable                 | ![Docker Build Master](https://github.com/elmerfdz/docker-bind/workflows/Docker%20Build%20Master/badge.svg)  | 
| dev | development, pre-release      | ![Docker Build Dev](https://github.com/elmerfdz/docker-bind/workflows/Docker%20Build%20Dev/badge.svg)     |
| exp | unstable, experimental        | ![Docker Build Exp](https://github.com/elmerfdz/docker-bind/workflows/Docker%20Build%20Exp/badge.svg)   | 

**Docker Run**

```
docker run -d --name='Traktarr' --net='bridge' -e TZ="Europe/London" -e 'PUID'='99' -e 'PGID'='100' -e 'DELAY'='' -e 'SORT'='rating' -e 'NOSEARCH'='yes' -e 'NOTIFICATIONS'='yes' -e 'BLACKLIST'='yes' -e 'RUNNOW'='no' -e 'SKIPUPDATE'='no' -e 'APP_BRANCH'='master' -v '<path to data>':'/config':'rw' 'eafxx/traktarr:latest'

```
OR

**Docker Compose**

```
    traktarr:
        container_name: traktarr
        image: eafxx/traktarr
        volumes:
            - <path to data>:/config
        environment:
            - PUID=<uid>
            - PGID=<gid>        
            - TZ=<timezone>
	    - DELAY=2.5	    
	    - SORT=rating
	    - NOSEARCH=yes
	    - NOTIFICATIONS=yes
	    - BLACKLIST=yes
	    - RUNNOW=no
	    - SKIPUPDATE=no
	    - APP_BRANCH=master      
```

OR 

**Unraid**

   Open Community Applications

1. Open the 'Apps' tab and
2. Search for 'traktarr'
3. Click on the Install button




**NOTE:** On the first run, the container will create a config.json in the /config folder and it will exit, add in your details for Sonarr, Radarr and your Trakt app info (complete step 2 first), then start or restart the container.

## Parameters

Container images are configured using parameters passed at runtime (such as those above). 

| Parameter | Function |
| :----: | --- |
| `-e PUID=99` | For UserID - see below for explanation |
| `-e PGID=100` | For GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e DELAY=2.5` | Optional variable, Seconds between each add request to Sonarr/Radar [default: 2.5] |
| `-e SORT=rating` | Votes or rating or release, sort list to process |
| `-e NOSEARCH=yes` | Disable search when adding to Sonarr/Radarr|
| `-e NOTIFICATIONS=yes` | Disable notifications |
| `-e BLACKLIST=yes` | Enables/disables the blacklist when running app |
| `-e RUNNOW=no` | Do a first run immediately without waiting |
| `-e SKIPUPDATE=no` | Skip auto-update of the Traktarr app on container restarts, options: yes/no, default: no |
| `-e APP_BRANCH=master` | Choose the GitHub branch of the Traktarr app, options: master/develop, default: master |
| `-v /config` | Contains all relevant configuration files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

# 2. App Configuration

Follow the readme on the project  repo: [Link](https://github.com/l3uddz/traktarr#2-create-a-trakt-application)
