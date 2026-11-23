FROM golang:1.24 AS build

ARG MINIO_TAG
RUN test -n "${MINIO_TAG}" \
 && git clone --depth 1 --branch "${MINIO_TAG}" https://github.com/minio/minio.git /src \
 && cd /src \
 && CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /minio .

FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=build /minio /usr/bin/minio
EXPOSE 9000 9001
ENTRYPOINT ["/usr/bin/minio"]
