FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y procps

COPY server-stats.sh .

CMD ["bash", "server-stats.sh"]

