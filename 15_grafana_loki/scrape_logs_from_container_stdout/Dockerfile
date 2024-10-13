# Stage 1: Build application
FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o webapp main.go

# Stage 2: Run application
FROM alpine:3.20

WORKDIR /app

ENV PORT="8080" \
    LOG_PATH="/var/log/webapp.log"

COPY --from=builder /app/public ./public
COPY --from=builder /app/webapp ./webapp

EXPOSE 8080

CMD ["./webapp"]