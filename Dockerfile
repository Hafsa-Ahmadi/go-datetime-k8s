# Stage 1: Build the Go app
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN go mod tidy
RUN go build -o datetime-app

# Stage 2: Run the app with a smaller image
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/datetime-app .

EXPOSE 3000

CMD ["./datetime-app"]
