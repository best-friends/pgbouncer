# best-friends/pgbouncer

[![docker](https://github.com/best-friends/pgbouncer/actions/workflows/docker.yml/badge.svg)](https://github.com/best-friends/pgbouncer/actions/workflows/docker.yml)

This is a [PgBouncer](https://www.pgbouncer.org/) container for [best-friends.chat](https://best-friends.chat).

## Usage

1. `docker pull ghcr.io/best-friends/pgbouncer:latest`
2. Set up [required environment variables](#required-environment-variables)
3. Run the container as you like

## Required environment variables

- `POSTGRES_DB` : The database name of PostgreSQL
- `POSTGRES_HOST` : The host of PostgreSQL
- `POSTGRES_PORT` : The port of PostgreSQL
- `POSTGRES_USER` : The user name of PostgreSQL
- `POSTGRES_PASSWORD` : The password of PostgreSQL

## Optional environment variables

- `PGBOUNCER_USER` / `PGBOUNCER_PASS` : The user name and password of PgBouncer's user (default: `POSTGRES_USER` and `POSTGRES_PASSWORD`)
- `PGBOUNCER_ADMIN_USER` / `PGBOUNCER_ADMIN_PASS` : The user name and password of PgBouncer's admin user (default: `PGBOUNCER_USER` and `PGBOUNCER_PASS`)
- `PGBOUNCER_STATS_USER` / `PGBOUNCER_STATS_PASS` : The user name and password of PgBouncer's stats user (default: `PGBOUNCER_USER` and `PGBOUNCER_PASS`)

## PgBouncer configurations

see [entrypoint.sh](https://github.com/best-friends/pgbouncer/blob/main/rootfs/usr/local/bin/entrypoint.sh) and [PgBouncer documents](https://www.pgbouncer.org/config.html).

## License

MIT License
