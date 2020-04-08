FROM golang:1.14.1-buster AS build
RUN apk --no-cache add gcc g++ make
RUN apk add git
WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/gin-gonic/gin
RUN GOOS=linux go build -ldflags="-s -w" -o ./bin/test ./main.go

FROM 1.14.1-buster
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=build /go/src/app/bin /go/bin
EXPOSE 8080
ENTRYPOINT /go/bin/test --port 8080