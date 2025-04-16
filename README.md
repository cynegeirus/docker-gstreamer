# GStreamer Docker Streaming Platform

This project sets up a GStreamer-based video streaming platform that allows you to stream via UDP or HLS. The entire setup is containerized with Docker, making it easy to configure and expose to the outside world.

## Contents

- GStreamer + NGINX live streaming platform
- Selectable streaming types: UDP or HLS
- Parameterized configuration via `config` files
- Docker and Docker Compose support
- Advanced NGINX configuration
- Volume support for external storage (HLS)

## Directory Structure

```
docker-gstreamer/
├── streamer/
│   ├── config         # Configuration for UDP/HLS Streaming
│   ├── entrypoint.sh  # Script to start the streaming
│   ├── nginx.conf     # Advanced NGINX configuration
├── hls/               # Directory where HLS segments are stored (volume)
├── Dockerfile         # GStreamer + NGINX image
├── docker-compose.yml
```

## Usage

### 1. Select Your Environment Variables

**For UDP/HLS Streaming:**  
Use the `config` file in `streamer/`:

```env
VIDEO_SRC=videotestsrc is-live=true pattern=ball
ENCODER=x264enc tune=zerolatency bitrate=512 speed-preset=superfast
PAYLOADER=rtph264pay config-interval=1 pt=96
UDP_SINK=udpsink host=127.0.0.1 port=5000
HLS_PAYLOADER=mpegtsmux
HLS_SINK=hlssink max-files=5 target-duration=2 playlist-root=http://localhost:8080 location=/app/hls/segment_%05d.ts playlist-location=/app/hls/playlist.m3u8
```

### 2. Start the Compose Setup

```bash
docker-compose up --build
```

## Access the Stream

- **UDP Stream:**  
  `udp://localhost:5000` (you can open it with VLC or any compatible player)

- **HLS Stream:**  
  `http://localhost:8080/playlist.m3u8`  
  HLS segments are automatically written to the `hls/` folder.

## License

This project is licensed under the [MIT License](LICENSE). See the license file for details.

## Issues, Feature Requests or Support

Please use the Issue > New Issue button to submit issues, feature requests or support issues directly to me. You can also send an e-mail to akin.bicer@outlook.com.tr.
