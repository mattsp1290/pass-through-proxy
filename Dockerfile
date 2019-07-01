FROM crystallang/crystal:0.29.0

COPY . ./
RUN shards build --production
RUN stat /bin/pass-through-proxy

FROM traefik:v2.0-alpine
COPY --from=0 /bin/pass-through-proxy /
RUN find / -name 'pass-through-proxy'
RUN id root
RUN id -G $(whoami)
RUN chmod +x /pass-through-proxy
RUN stat /pass-through-proxy
RUN /pass-through-proxy