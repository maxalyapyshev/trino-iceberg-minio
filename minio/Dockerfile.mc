FROM golang:1.24 AS build
ARG MC_TAG
RUN test -n "${MC_TAG}" \
 && git clone --depth 1 --branch "${MC_TAG}" https://github.com/minio/mc.git /src \
 && cd /src \
 && CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /mc .

FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=build /mc /usr/bin/mc
