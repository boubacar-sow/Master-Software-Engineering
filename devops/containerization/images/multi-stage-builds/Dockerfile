# Build stage — updated to Go 1.24
FROM golang:1.24.4-alpine AS builder
WORKDIR /src

# Copy go.mod and go.sum if present
COPY go.mod ./
# (Optional but useful if go.sum exists)
# COPY go.sum ./

# Download dependencies
RUN go mod tidy

# Copy app code
COPY main.go ./

# Build the binary
RUN go build -o app

# Final image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app .
CMD ["./app"]
