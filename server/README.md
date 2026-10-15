# server

Single-node hosting for the monoapp server, using the prebuilt
`taras0mazepa/monoapp` image.

## Setup

Solomiya reading practices run in their own container, started by monoapp
through the host docker socket. Before the first run:

1. Log in to ghcr with a GitHub token that has `read:packages`, so the private
   solomiya reading image can be pulled:

   ```sh
   docker login ghcr.io
   ```

2. Put the OpenRouter key into `.env` next to `compose.yaml`:

   ```sh
   echo "OPENROUTER_API_KEY=..." > .env
   ```

## Run

```sh
docker compose up -d
```

The server listens on port `8080`. Its data lives in the `monoapp-data` volume,
so it survives restarts and image upgrades.

## Upgrade

Bump the image tag in `compose.yaml`, then:

```sh
docker compose pull
docker compose up -d
```
