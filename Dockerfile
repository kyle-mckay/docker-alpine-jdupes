# Start with the latest Alpine image
FROM alpine:latest

# Install zip and any other tools
RUN apk add --no-cache zip bash

# Optional: Set a default working directory
WORKDIR /app
