# postgres-partman

Docker image based on PostgreSQL 17 Alpine with pre-installed [pg_partman](https://github.com/pgpartman/pg_partman) extension for automated partition management.

## Features

- PostgreSQL 17 Alpine
- pg_partman extension pre-installed and configured
- Multi-platform support (amd64, arm64)
- Background worker configured for automatic partition maintenance

## Usage

```bash
docker pull rom8726/postgres-partman:latest
docker run -e POSTGRES_PASSWORD=mypassword rom8726/postgres-partman:latest
```

## Building

```bash
docker build -t postgres-partman .
```
