# Homebrew Bottle Mirror
mirror tools for syncing homebrew bottle files.

## usage

### general way
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
