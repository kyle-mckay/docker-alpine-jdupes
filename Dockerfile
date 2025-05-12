# Alpine-based image with jdupes
FROM alpine:latest

# Install jdupes
RUN apk add --no-cache jdupes

# Set default working directory
WORKDIR /data

# Default command (can be overridden)
ENTRYPOINT ["jdupes"]
