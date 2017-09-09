# Google Music uploader

[![Docker Pulls](https://img.shields.io/docker/pulls/strm/gmusic-uploader.svg?style=plastic)](https://hub.docker.com/r/strm/gmusic-uploader/)

This image is a set of scripts and tools to monitor and upload musics from one folder to your Google Music account. Here an example docker compose configuration with a torrent (Transmission) server downloading your musics and a uploader (this image) uploading it to Google Music

```
version: '3'

services:

    transmission-music:
        image: strm/transmission
		ports:
			- "8090:9091"
        volumes:
            - /music-downloaded:/downloads
            - /music-incomplete:/incomplete
        environment:
            - TRANSMISSION_PASSWORD=secret
            - TRANSMISSION_DOWNLOAD_LIMIT=2048
            - TRANSMISSION_DOWNLOAD_QUEUE=1

	gmusic-uploader:
		image: strm/gmusic-uploader
		volumes:
			- /music-downloaded:/data
		environment:
			- UPLOADER_MAC=00:00:00:00:00:00
			- AUTH_TOKEN=A_VERY_VERY_LONG_STRING
```

# Configuration

There are two variables:

  * `UPLOADER_MAC` - Set any valid MAC address, is required by the library and by the protocol to authenticate you
  * `AUTH_TOKEN` - Is your authentication token
