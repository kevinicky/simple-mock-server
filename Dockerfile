FROM golang:1.21.5-alpine3.17 AS builder
LABEL authors="kevinicky"
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -tags=jsoniter -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

FROM scratch
LABEL authors="kevinicky"

ENV GO_APP_PORT 80

COPY --from=builder /build/main /app/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
WORKDIR /app
ENTRYPOINT ["./main"]

EXPOSE $GO_APP_PORT