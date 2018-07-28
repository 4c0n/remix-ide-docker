FROM ubuntu:18.10

USER root

RUN apt-get update && apt-get install -y npm git

RUN npm install -g remix-ide

RUN sed -i s/127.0.0.1/0.0.0.0/g /usr/local/lib/node_modules/remix-ide/node_modules/remixd/src/websocket.js

RUN sed -i s/127.0.0.1/0.0.0.0/g /usr/local/lib/node_modules/remix-ide/bin/remix-ide

EXPOSE 8080
EXPOSE 65520

ENTRYPOINT ["/usr/local/bin/remix-ide", "/app"]
