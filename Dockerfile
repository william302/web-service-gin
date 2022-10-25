FROM golang:1.18-alpine

WORKDIR /app

ENV GOPROXY=https://goproxy.cn,direct

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /web-service-gin

## Deploy

EXPOSE 8080

CMD [ "/web-service-gin" ]