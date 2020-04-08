FROM golang:1.14.1-buster AS build
RUN apt-get install gcc g++ make && \
    apt-get install git && \
    apt-get clean;
WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/gin-gonic/gin
RUN GOOS=linux go build -ldflags="-s -w" -o ./bin/test ./main.go

FROM buster
RUN apt-get install ca-certificates && \
    apt-get clean;
WORKDIR /usr/bin
COPY --from=build /go/src/app/bin /go/bin
EXPOSE 8080
ENTRYPOINT /go/bin/test --port 8080