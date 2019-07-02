# FROM crystallang/crystal:0.29.0
# FROM alpine:latest
FROM rust:latest
RUN apt-get update
RUN apt-get install musl-tools -y
RUN rustup target add x86_64-unknown-linux-musl
COPY Cargo.toml .
COPY ./src ./src
RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

FROM traefik:v2.0-alpine
COPY run.sh /
RUN chmod +x /run.sh
COPY --from=0 /target/x86_64-unknown-linux-musl/release/pass-through-proxy /
ENTRYPOINT /run.sh
