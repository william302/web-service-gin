FROM golang:1.18-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /web-service-gin

## Deploy

FROM gcr.io/distroless/base-debian10:debug

WORKDIR /

COPY --from=build /web-service-gin /web-service-gin

EXPOSE 8080

ENTRYPOINT ["/web-service-gin"]