FROM ubuntu:18.10

ARG REMIXD_COMMIT=fbfe18d7068a8b4ccda23b4e716f0b949c922686
ARG REMIX_VERSION=0.7.6
ARG NVM_VERSION=0.34.0
ENV NPM_VERSION=10.15.3

USER root
RUN apt-get update && apt-get install -yqq curl git python build-essential wget
COPY ./entrypoint.sh /usr/local/bin
RUN yes | adduser --disabled-password remix && mkdir /app

USER remix
WORKDIR /home/remix
RUN curl -o- "https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh" | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install $NPM_VERSION && \
    npm install remix-ide@$REMIX_VERSION -g && \
    sed -i s/"remixd.git"/"remixd.git#$REMIXD_COMMIT"/g $HOME/.nvm/versions/node/v$NPM_VERSION/lib/node_modules/remix-ide/package.json && \
    cd $HOME/.nvm/versions/node/v$NPM_VERSION/lib/node_modules/remix-ide && \
    rm -rf node_modules && \
    npm install

RUN sed -i s/", loopback"//g $HOME/.nvm/versions/node/v$NPM_VERSION/lib/node_modules/remix-ide/node_modules/remixd/src/websocket.js
RUN sed -i s/127.0.0.1/0.0.0.0/g $HOME/.nvm/versions/node/v$NPM_VERSION/lib/node_modules/remix-ide/bin/remix-ide

EXPOSE 8080
EXPOSE 65520

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
