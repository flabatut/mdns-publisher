FROM mcr.microsoft.com/devcontainers/go:1.21-bullseye AS builder
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GO111MODULE=on go build --mod=vendor -o mdns-publisher

FROM scratch
COPY --from=builder /build/mdns-publisher /usr/bin/

ENTRYPOINT ["/usr/bin/mdns-publisher"]

LABEL io.k8s.display-name="mDNS-publisher" \
      io.k8s.description="Configurable mDNS service publisher" \
      maintainer="Antoni Segura Puimedon <antoni@redhat.com>"
