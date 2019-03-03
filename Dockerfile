FROM smartentry/alpine:3.4-0.3.13

MAINTAINER Yifan Gao <docker@yfgao.com>

ADD .docker $ASSETS_DIR

RUN smartentry.sh build

ADD . /home/homebrew/.linuxbrew/homebrew/Library/Taps/gaoyifan/homebrew-bottle-mirror
ADD . /home/linuxbrew/.linuxbrew/homebrew/Library/Taps/gaoyifan/homebrew-bottle-mirror

VOLUME /srv/data /var/log
