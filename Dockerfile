# Dockerfile
FROM golang:1.11.1-alpine3.8 as builder
ENV GO111MODULE on
WORKDIR $GOPATH/src/github.com/sinnott74/DockerCloudFoundryDemo

# Go requires Git to download dependencies
RUN apk add git

# Copy our module definition
COPY go.mod ./

# Download module dependencies
RUN go mod download

# Copy source files - this is the layer most likely to change
COPY . ./

# Build binary, specifying the architecture we want and removing debugging information with the -w -s build flags
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s"

FROM alpine:3.8

# Choose port to expose
EXPOSE 8008

# Copy binary
COPY --from=builder /go/src/github.com/sinnott74/DockerCloudFoundryDemo/DockerCloudFoundryDemo .
CMD ["./DockerCloudFoundryDemo"]