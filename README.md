# remix-ide-docker
Dockerfile for building remix-ide docker image

After building the image (`$ docker build . --tag 4c0n/remix-ide`), the container can be started as follows:
`$ docker run -itd -p8080:8080 -p65520:65520 -v/path/to/your/solidity/files/:/app 4c0n/remix-ide`

When the container is successfully started the remix IDE can be accessed through the browser, using url:
`http://localhost:8080`

Remixd is automatically started in the same container, so it can be used right away (to make your local files available in the browser).
