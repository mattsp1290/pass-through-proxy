# FROM crystallang/crystal:0.29.0
FROM alpine:latest
RUN apk add -u crystal shards libc-dev
COPY shard.yml .
COPY ./src ./src
RUN shards install
RUN crystal build --release --static ./src/pass-through-proxy.cr -o /bin/pass-through-proxy

FROM traefik:v2.0-alpine
COPY run.sh /
RUN chmod +x /run.sh
COPY --from=0 /bin/pass-through-proxy /
ENTRYPOINT /run.sh
