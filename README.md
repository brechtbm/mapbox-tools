# Mapbox tools

A collection of Mapbox tools on Docker.

## Usage

Commands are run inside the container's `/workdir` folder.

## Tools

### Tippecanoe

`$ docker run -v $(pwd):/workdir stefda/mapbox-tools tippecanoe data/tiles.geojson`

See the [mapbox/tippecanoe](https://github.com/mapbox/tippecanoe) repo for a detailed api documentation. 