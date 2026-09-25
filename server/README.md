# server

Single-node hosting for the [monoapp](https://github.com/TarasMazepa/monoapp)
server, using the prebuilt `taras0mazepa/monoapp` image.

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
