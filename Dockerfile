FROM debian:latest
USER root
RUN apt-get update && apt-get install -y \
    tzdata \
    rsync \
    cron \
    && rm -rf /var/lib/apt/lists/*
COPY --chmod=755 "entrypoint.sh" "/entrypoint.sh"
RUN touch /rsync.log
ENTRYPOINT ["/entrypoint.sh"]
