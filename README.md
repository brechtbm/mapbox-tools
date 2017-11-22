# Mapbox tools

A collection of Mapbox tools on Docker.

## How to use

By default, all commands are run inside the container's `/workdir` folder. If you want to run the bundled commands relative to your current path, you can mount the directory with `-v $(pwd):/workdir`.  

## Tools

### Tippecanoe

`$ docker run -v $(pwd):/workdir stefda/mapbox-tools tippecanoe data/tiles.geojson`

Detailed api documentation for the tool is in the [mapbox/tippecanoe](https://github.com/mapbox/tippecanoe) repo.
 