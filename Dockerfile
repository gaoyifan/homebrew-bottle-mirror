FROM ruby

MAINTAINER Yifan Gao "git@gaoyifan.com"

RUN git clone git://github.com/gaoyifan/linuxbrew.git ~/.linuxbrew \
    && git clone git://github.com/homebrew/homebrew.git ~/.linuxbrew/homebrew \
    && export PATH="$HOME/.linuxbrew/bin:$PATH" \
    && brew tap gaoyifan/homebrew-bottle-mirror \
    && echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.bashrc \
    && echo 'export HOMEBREW_BOTTLE_DOMAIN=https://homebrew.bintray.com' >> ~/.bashrc

VOLUME /root/.cache/Homebrew/

COPY entrypoint.sh /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
