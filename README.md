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

# How to get the AUTH_TOKEN ?

This is the token to connect to your Google Music account, you will need to generate it only once, run a shell in the container as following

```
docker run --rm -it --entrypoint /bin/bash strm/gmusic-uploader
```

Then run

```
/upload.py --cred /auth ; cat /auth.cred | base64
```

You will be asked to access an URL, where you will have to approve this application to access your account. After that, paste the code returned in the console. The result will be a Base64 encoded string (representing the key file), in just one line, use it as the value for `AUTH_TOKEN` variable


# WARNING

  * Don't download pirated music
  * Your music local will be deleted after it is successfuly uploaded

# Credits

Thanks to [Simon Weber](https://github.com/simon-weber/gmusicapi) for creating an API for Google Music, and [thebigmunch](https://github.com/thebigmunch/gmusicapi-scripts) for creating the upload script
