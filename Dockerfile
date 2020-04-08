FROM golang:1.14.1-buster AS build
RUN apt-get install -y gcc g++ make && \
    apt-get install -y git && \
    apt-get clean;
WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/gin-gonic/gin
RUN GOOS=linux go build -ldflags="-s -w" -o ./bin/test ./main.go

FROM debian:buster
RUN apt-get update && apt-get -y install ca-certificates && \
    apt-get clean;
WORKDIR /usr/bin
COPY --from=build /go/src/app/bin /go/bin
EXPOSE 8080
ENTRYPOINT /go/bin/test --port 8080