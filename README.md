# Homebrew Bottle Mirror
mirror tools for syncing homebrew bottle files.

## Usage

### General way

run the following command on your Mac:

```
brew tap gaoyifan/homebrew-bottle-mirror
brew bottle-mirror
```

### docker

```
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

add the following line to your `~/.bashrc` (if you use bash)

```
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
```
