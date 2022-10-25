FROM golang:1.18-buster AS build

WORKDIR /app

ENV GOPROXY=https://goproxy.cn,direct

ENV CGO_ENABLED=0

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /web-service-gin

## Deploy

FROM registry.cn-hangzhou.aliyuncs.com/launcher/alpine:latest

WORKDIR /

COPY --from=build /web-service-gin /web-service-gin

EXPOSE 8080

ENTRYPOINT ["/web-service-gin"]