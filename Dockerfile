FROM ubuntu:18.10

USER root

RUN apt-get update && apt-get install -yqq curl git python build-essential wget

COPY ./entrypoint.sh /usr/local/bin

RUN yes | adduser --disabled-password remix

USER remix

WORKDIR /home/remix

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install 10.10.0 && \
    npm install remix-ide@0.7.1 -g && \
    sed -i s/"remixd.git"/"remixd.git#a0823a3ee222c0b444197c138441aad2087f6448"/g $HOME/.nvm/versions/node/v10.10.0/lib/node_modules/remix-ide/package.json && \
    cd $HOME/.nvm/versions/node/v10.10.0/lib/node_modules/remix-ide && \
    rm -rf node_modules && \
    npm install

RUN sed -i s/", loopback"//g $HOME/.nvm/versions/node/v10.10.0/lib/node_modules/remix-ide/node_modules/remixd/src/websocket.js

RUN sed -i s/127.0.0.1/0.0.0.0/g $HOME/.nvm/versions/node/v10.10.0/lib/node_modules/remix-ide/bin/remix-ide

EXPOSE 8080
EXPOSE 65520

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
