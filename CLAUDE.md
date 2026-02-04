# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **DevContainer template** for Symfony development environments. It is not a runnable application itself—users copy the `.devcontainer/` folder into their own Symfony projects to get a containerized development setup.

## Architecture

Three-container Docker stack:

1. **dev** - PHP 8.5 CLI with Composer, Symfony CLI, Castor, and common extensions
2. **database** - PostgreSQL 16 (Alpine)
3. **mailer** - Mailpit for email testing

Key files:
- `Dockerfile` - Custom PHP image definition
- `.devcontainer/compose.yml` - Service orchestration
- `.devcontainer/devcontainer.json` - VS Code DevContainer configuration

## Docker Image Build

Changes to `Dockerfile` trigger CI/CD on push to main. The workflow builds a multi-arch image (amd64/arm64) and pushes to Docker Hub as `yoanbernabeu/symfony-dev-container:latest`.

Required GitHub secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`

## Port Forwarding

- `8000` - PHP development server (configurable via `BACKEND_PORT`)
- `8025` - Mailpit web UI
- `1025` - SMTP (internal)
- `5432` - PostgreSQL (internal)

## Environment Variables

Configured in `.devcontainer/compose.yml`:
- `BACKEND_PORT` (default: 8000)
- `POSTGRES_USER` (default: app)
- `POSTGRES_PASSWORD` (default: !ChangeMe!)
- `POSTGRES_DB` (default: app)
- `POSTGRES_VERSION` (default: 16)

## Customization

To add PHP extensions: modify `Dockerfile`, rebuild, and push to your own Docker registry, then update the `image` field in `compose.yml`.
