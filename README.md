# Inception (42) — Docker + docker-compose

Docker-based infrastructure project using docker-compose to orchestrate multiple containerized services for a complete web application stack deployment.

Multi-container infrastructure with **Nginx (TLS)**, **WordPress (PHP-FPM)** and **MariaDB**, orchestrated with **docker-compose**.

Bonus included in this repository: **Redis**, **FTP**, **static site**, **Adminer**, **cAdvisor**.

## Prerequisites

- Linux
- Docker + `docker compose` (v2)
- `make`

## Project structure

```
Inception/
├── Makefile
└── srcs/
  ├── .env.example
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        ├── wordpress/
        └── bonus/
            ├── adminer/
            ├── cadvisor/
            ├── ftp/
            ├── redis/
            └── static-site/
```

## Configuration

This repository provides an example file: [srcs/.env.example](srcs/.env.example).

Create your local env file (not committed):

```bash
cp srcs/.env.example srcs/.env
```

Important notes:
- `DOMAIN_NAME` is used during the automatic WordPress installation (WP-CLI).
- Nginx `server_name` values are configured in [srcs/requirements/nginx/conf/nginx.conf](srcs/requirements/nginx/conf/nginx.conf) (defaults: `itaharbo.42.fr` / `www.itaharbo.42.fr` and `mysite.test`).

## Volumes (persistence)

The compose file bind-mounts data on the host machine (see [srcs/docker-compose.yml](srcs/docker-compose.yml)):
- WordPress : `/home/itaharbo/data/wordpress`
- MariaDB : `/home/itaharbo/data/mariadb`

The `Makefile` creates these directories automatically via the `create_dirs` target.

## Run

From the project root:

```bash
make
```

Useful commands:

```bash
make up      # start services
make build   # rebuild + start
make down    # stop
make ps      # status
make logs    # logs (follow)
make fclean  # full cleanup (containers/images/volumes + host data)
```

## Security (public repo)

For a public repository, it is strongly recommended to **never commit**:
- passwords (even “fake” ones, because they often get reused by mistake),
- `.env` files,
- a `secrets/` directory (or any credential dump).

Good practice:
- keep `srcs/.env` locally (not committed),
- provide [srcs/.env.example](srcs/.env.example) with placeholder values,
- add `srcs/.env` and `secrets/` to `.gitignore`.

If a sensitive file has already been pushed, deleting it is not always enough (it can remain in Git history): consider a history rewrite + password rotation.

## Access & Ports

### 1) Local DNS (required for the domain)

To test locally, add (at minimum) to `/etc/hosts`:

```text
127.0.0.1 itaharbo.42.fr www.itaharbo.42.fr
127.0.0.1 mysite.test
```

If you run this on a remote VM, replace `127.0.0.1` with the VM IP.

### 2) Exposed services

- **WordPress (Nginx TLS)**: `https://itaharbo.42.fr` (port **443**)
  - Self-signed certificate (generated on startup), browser warning is expected.
- **Static site (bonus)**: `https://mysite.test` (port **443**, reverse proxy to `static-site`)
- **cAdvisor (bonus)**: `http://localhost:8080` (port **8080**)
- **FTP (bonus)**:
  - port **21** + passive **21100-21110**
  - `pasv_address` is configured in [srcs/requirements/bonus/ftp/conf/vsftpd.conf](srcs/requirements/bonus/ftp/conf/vsftpd.conf) (currently `itaharbo.42.fr`)

### Adminer (bonus)

The `adminer` service exposes port `9000` and maps `8081:9000`, but the image starts **PHP-FPM** (FastCGI): it is **not** an HTTP server.

As a result, `http://localhost:8081` will not work properly until Adminer is served behind a web server (Nginx/Apache or `php -S`).

## First run behavior

- WordPress is downloaded and configured automatically (WP-CLI) if `wp-config.php` does not exist.
- An admin + a second user are created from `srcs/.env` variables.
- Redis is configured in WordPress (host `redis`, port `6379`) and the `redis-cache` plugin is installed/activated.

## Author

[@itaharbo91](https://github.com/itaharbo91)

## GitHub Description

Docker-based infrastructure project using docker-compose to orchestrate multiple containerized services for a complete web application stack deployment.