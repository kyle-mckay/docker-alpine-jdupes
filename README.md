# `docker-alpine-jdupes`

## Docker Image for Deduplication Using `jdupes`

This Docker image allows you to run **[jdupes](https://codeberg.org/jbruchon/jdupes)** (a tool for finding and deduplicating files) in a minimal Alpine-based container. It provides flexibility through environment variables for configuring `jdupes` flags and paths dynamically.

## Features

* **Minimal Alpine-based Image**: Small footprint and fast.
* **Customizable Deduplication Arguments**: Use environment variables to specify `jdupes` flags.
* **Multiple Paths Support**: Specify multiple paths to deduplicate using environment variables.
* **Docker Compose Ready**: Easily set up and run with `docker-compose`.

## Prerequisites

* Docker and Docker Compose installed on your system.
* Basic understanding of Docker and Docker Compose.

## Environment Variables

### `JDUPES_ARGS`

This environment variable defines the flags to pass to the `jdupes` command. See [the original repo](https://codeberg.org/jbruchon/jdupes) for full arguments

**Example flags:**

* `-r` – Recurse through directories.
* `-A` – Exclude hidden files.
* `-m` – Summarize duplicate information.

**Example**:

```bash
JDUPES_ARGS: "-r -A -m"
```

### `JDUPES_PATHS`

This environment variable defines the paths (space-separated) to the directories you want to deduplicate.

**Example**:

```bash
JDUPES_PATHS: "/data/folder1 /data/folder2"
```

Each path corresponds to a directory you mount from your host machine. The paths will be passed directly to `jdupes` for deduplication.

## Usage

### 1. Clone the Repository

If you have this repository locally:

```bash
git clone https://github.com/yourusername/docker-alpine-jdupes.git
cd docker-alpine-jdupes
```

### 2. Build the Docker Image

If you have a local copy of the Dockerfile:

```bash
docker-compose build
```

This will build the Docker image based on the provided `Dockerfile`.

### 3. Configure Volumes and Environment Variables in `docker-compose.yml`

Update the `docker-compose.yml` file to specify your paths and flags. Example:

```yaml
version: "3.9"

services:
  jdupes:
    image: yourdockerhubuser/docker-alpine-jdupes:latest  # Use the image you push
    container_name: jdupes
    environment:
      JDUPES_ARGS: "-r -A -m"  # Specify your flags
      JDUPES_PATHS: "/data/folder1 /data/folder2"  # Specify the paths to deduplicate
    volumes:
      - /path/on/host/folder1:/data/folder1:ro  # Mount directories from host
      - /path/on/host/folder2:/data/folder2:ro  # Mount additional directories
    restart: "no"
    command: >
      sh -c "jdupes $JDUPES_ARGS $JDUPES_PATHS"  # Use the variables to run the command
```

Replace `/path/on/host/folder1` and `/path/on/host/folder2` with the actual paths on your host system where your files are located.

### 4. Start the Deduplication Process

Run the following command to start the deduplication process:

```bash
docker-compose up
```

This will start the container and execute `jdupes` on the specified paths with the defined flags.

### 5. Stop the Container

Once the process is complete, you can stop the container with:

```bash
docker-compose down
```

### 6. (Optional) Schedule Regular Runs with Cron

If you'd like to automate the deduplication process, you can schedule regular runs using `cron`. For example, you can use a `cron` job on your host system to run `docker-compose up` at a specific interval.

```bash
# Edit crontab
crontab -e

# Add a cron job to run every day at 2 AM
0 2 * * * cd /path/to/docker-alpine-jdupes && docker-compose up
```

This will automatically run the deduplication process daily at 2 AM.

---

## Example Command Breakdown

If you set the following environment variables:

```yaml
environment:
  JDUPES_ARGS: "-r -A -m"
  JDUPES_PATHS: "/data/folder1 /data/folder2"
```

The Docker container will run the following command:

```bash
jdupes -r -A -m /data/folder1 /data/folder2
```

This command will recursively search for duplicates in `folder1` and `folder2`, excluding hidden files, and summarize the duplicate information.

---

## Customization

You can further customize the environment variables to fit your deduplication needs. You can modify:

* **Flags**: Add or remove `jdupes` flags in the `JDUPES_ARGS` environment variable.
* **Paths**: Add more directories to `JDUPES_PATHS` if you need to deduplicate files from multiple locations.

## Troubleshooting

* **No Duplicates Found**: If no duplicates are found, make sure the paths are correctly mounted and contain files.
* **Permissions**: Ensure that the files or directories you're trying to deduplicate have appropriate read permissions.
