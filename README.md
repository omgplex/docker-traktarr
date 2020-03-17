# Traktarr

**traktarr** uses Trakt to add new shows into Sonarr and new movies into Radarr.

Types of Trakt lists supported:

- Official Trakt Lists

  - Trending

  - Popular

  - Anticipated

  - Boxoffice

  - Most Watched

  - Most Played

- Public Lists

- Private Lists*

  - Watchlist

  - Custom List(s)

\* Support for multiple (authenticated) users.

---

- [Requirements](#requirements)
- [Installation](#installation)
	- [1. Base Install (Docker)](#1-base-install-docker)
	- [2. Create a Trakt Application](#2-create-a-trakt-application)
	- [3. Authenticate User(s) (optional)](#3-authenticate-users-optional)
- [Configuration](#configuration)

---


# Requirements

1. Trakt account

2. Trakt application (see instructions below)

3. Configure Arr apps

# Installation

## 1. Base Install (Docker)

**unRAID Template**
[Link](https://github.com/elmerfdz/traktarr/blob/master/traktarr-unRAID.xml)

OR 

**Docker Create**

```
docker create \
  --name=traktarr \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid> \
  -e TZ=<timezone> \
  -e DELAY='' \
  -e SORT='rating' \
  -e NOSEARCH='yes' \
  -e NOTIFICATIONS='yes' \
  -e BLACKLIST='yes' \
  -e RUNNOW='no' \ 
  -e SKIPUPDATE='no' \ 
  -e APP_BRANCH='master' \         
  eafxx/traktarr

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

**Docker Run**

```
docker run -d --name='Traktarr' --net='bridge' -e TZ="Europe/London" -e 'PUID'='99' -e 'PGID'='100' -e 'DELAY'='' -e 'SORT'='rating' -e 'NOSEARCH'='yes' -e 'NOTIFICATIONS'='yes' -e 'BLACKLIST'='yes' -e 'RUNNOW'='no' -e 'SKIPUPDATE'='no' -e 'APP_BRANCH'='master' -v '<path to data>':'/config':'rw' 'eafxx/traktarr:latest'

```
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

## 2. Create a Trakt Application

1. Create a Trakt application by going [here](https://trakt.tv/oauth/applications/new)

2. Enter a name for your application; for example `traktarr`

3. Enter `urn:ietf:wg:oauth:2.0:oob` in the `Redirect uri` field.

4. Click "SAVE APP".

5. Open the traktarr configuration file `config.json` and insert the Client ID in the `client_id` and the Client Secret in the `client_secret`, like this:

   ```
       {
           "trakt": {
               "client_id": "my_client_id",
               "client_secret": "my_client_secret_key"
           }
       }
   ```

## Authenticate User(s) (optional)

For each user you want to access the private lists for (i.e. watchlist and/or custom lists), you will need to to authenticate that user.

Repeat the following steps for every user you want to authenticate:

1. Run `traktarr trakt_authentication`

2. You wil get the following prompt:

   ```
   - We're talking to Trakt to get your verification code. Please wait a moment...
   - Go to: https://trakt.tv/activate on any device and enter A0XXXXXX. We'll be polling Trakt every 5 seconds for a reply
   ```
3. Go to https://trakt.tv/activate.

4. Enter the code you see in your terminal.

5. Click continue.

6. If you are not logged in to Trakt, login now.

7. Click "Accept".

8. You will get the message: "Woohoo! Your device is now connected and will automatically refresh in a few seconds.".

You've now authenticated the user.

You can repeat this process for as many users as you like.


# 3. Configuration

Follow the readme from the porject repo Repo: https://github.com/l3uddz/traktarr#configuration