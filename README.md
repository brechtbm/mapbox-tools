# Mapbox tools

A collection of Mapbox tools on Docker.

## How to use

By default, all commands are run inside the container's `/workdir` folder. If you want to run the bundled commands relative to your current path, you can mount the directory with `-v $(pwd):/workdir`.  

## Tools

### Tippecanoe

`$ docker run -v $(pwd):/workdir stefda/mapbox-tools tippecanoe -o data/coastline.mbtiles -zg data/coastline.geojson`

Detailed api documentation for the tool is in the [mapbox/tippecanoe](https://github.com/mapbox/tippecanoe) repo.

### Uploads API

`$ docker run -v $(pwd):/workdir -e MAPBOX_USERNAME=<username> -e MAPBOX_TOKEN=<token> stefda/mapbox-tools upload data/coastline.mbtiles coastline`

Based on the [excellent tutorial](https://www.mapbox.com/help/how-uploads-work/) to upload data to Mapbox studio.