FROM golang:1.18-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

ENV GOPROXY=https://goproxy.cn,direct


RUN go build -o /web-service-gin

## Deploy

EXPOSE 8080

CMD [ "/web-service-gin" ]