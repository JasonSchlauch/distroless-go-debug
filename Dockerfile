# docker image build -t go-debug .
# docker run -P -it go-debug
#/go/bin/dlv --headless --listen=:40000 exec /go/bin/app

FROM golang:1.22.0-bullseye as build

WORKDIR /go/src/app
COPY . .

# CGO_ENABLED is critial to successfully running dlv in static distro
RUN CGO_ENABLED=0 go install github.com/go-delve/delve/cmd/dlv@latest
RUN go mod download
RUN go vet -v
RUN go test -v

RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static-debian11:debug

COPY --from=build /go/bin /go/bin
COPY --from=build /go/pkg /go/pkg

EXPOSE 8080 40000

# Needs work, Docker complains about entry point at launch
#CMD ["/go/bin/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "--accept-multiclient", "--log", "exec", "/go/bin/app"]
