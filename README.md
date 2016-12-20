# Homebrew Bottle Mirror
mirror tools for syncing homebrew bottle files.

## Usage

### General way

run the following command on your Mac:

```shell
brew tap gaoyifan/bottle-mirror
brew bottle-mirror
```

### docker

```shell
# homebrew core repository
docker run -itd \
  --name=homebrew-bottles \
  -v $YOUR_REPOSITORY_DIR:/srv/data \
  gaoyifan/homebrew-bottle-mirror
```

```shell
# homebrew tap repository
docker run -itd \
  --name=homebrew-bottles \
  -e HOMEBREW_TAP=$tap \
  -v $YOUR_REPOSITORY_DIR:/srv/data \
  gaoyifan/homebrew-bottle-mirror
```

Some useful environment variables:

| Parameter              | Default value               | Description                              |
| :--------------------- | --------------------------- | ---------------------------------------- |
| DOCKER_UID             | 1000                        | program uid inside docker container      |
| HOMEBREW_TAP           | \<null\>                    | sync a specific tap  repository          |
| HOMEBREW_BOTTLE_DOMAIN | http://homebrew.bintray.com | upstream  repository                     |
| HOMEBREW_CACHE         | /srv/data                   | where the repository store inside the docker container |

available HOMEBREW_TAP value:
- dupes
- games
- gui
- python
- php
- science
- versions
- x11

[more information for docker](https://hub.docker.com/r/gaoyifan/homebrew-bottle-mirror/)

## Public mirror

```
https://mirrors.ustc.edu.cn/homebrew-bottles/
```

### How to use?

add the following line to your `~/.bash_profile` (if you use bash)

```shell
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
```

then load the new configration

```shell
$ source ~/.bash_profile
```
