# Use Debian as the base image
FROM debian:bullseye-slim

# Install jdupes and bash
RUN apt-get update && apt-get install -y jdupes bash && apt-get clean

# Set the working directory to /data (where mounted volumes will reside)
WORKDIR /data

# Set default environment variables for jdupes flags and paths
ENV JDUPES_ARGS=""
ENV JDUPES_PATHS=""

# Entrypoint will use /bin/bash to run the jdupes command
ENTRYPOINT ["/bin/bash", "-c"]

# Default command: expand JDUPES_ARGS and JDUPES_PATHS into the jdupes command
CMD ["echo 'Starting jdupes with args: $JDUPES_ARGS and paths: $JDUPES_PATHS' && jdupes $JDUPES_ARGS $JDUPES_PATHS"]
