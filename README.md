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
docker run -itd \
  --name=homebrew-bottles \
  -v $YOUR_REPOSITORY_DIR:/root/.cache/Homebrew/ \
  gaoyifan/homebrew-bottle-mirror
```

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
