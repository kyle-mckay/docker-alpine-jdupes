# Use a lightweight Debian image as the base
FROM debian:bullseye-slim

# Install jdupes and bash
RUN apt-get update && apt-get install -y \
    bash \
    jdupes \
    && rm -rf /var/lib/apt/lists/*

# Set working directory to /data (where mounted volumes will reside)
WORKDIR /data

# Set the default environment variables for jdupes flags and paths
# These can be overridden at runtime with `docker-compose.yml` or `docker run`
ENV JDUPES_ARGS=""
ENV JDUPES_PATHS=""

# Entrypoint will use /bin/sh to run the jdupes command
ENTRYPOINT ["/bin/sh", "-c"]

# Default command: expand JDUPES_ARGS and JDUPES_PATHS into the jdupes command
CMD ["jdupes $JDUPES_ARGS $JDUPES_PATHS"]
