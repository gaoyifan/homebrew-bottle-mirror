FROM ruby

MAINTAINER Yifan Gao "git@gaoyifan.com"

ENV CACHE_DIR="/etc/docker-homebrew-bottle-mirror"

ENV TEMPLATES_DIR="${CACHE_DIR}/templates" \
    ATTRIBUTE_FIX_LIST="${CACHE_DIR}/attribute_fix_list" \
    DEFAULT_ENV="${CACHE_DIR}/default_env" \
    MD5_CHECKLIST="${CACHE_DIR}/checklist" \
    BUILD_SCRIPT="${CACHE_DIR}/build.sh"

COPY docker/assets $CACHE_DIR

COPY docker/entrypoint/entrypoint.sh /sbin/entrypoint.sh

RUN /sbin/entrypoint.sh build

VOLUME /root/.cache/Homebrew/

VOLUME /var/log/homebrew-bottles/

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/sbin/sync.sh"]
