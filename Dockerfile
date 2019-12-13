FROM golang:1.8 AS build

WORKDIR /go/src/github.com/RubenHoms/maxscale_exporter
COPY . .
RUN go get -d -v ./...
RUN go install -v ./...
#RUN go get github.com/RubenHoms/maxscale_exporter
RUN make build

FROM alpine:3.10

COPY --from=build /go/src/github.com/RubenHoms/maxscale_exporter/maxscale_exporter /bin/maxscale_exporter
USER nobody
EXPOSE 9195
ENTRYPOINT ["/bin/maxscale_exporter"]
