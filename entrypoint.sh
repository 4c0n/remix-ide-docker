#!/bin/bash
export NVM_DIR="$HOME/.nvm"

echo "exported"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo "ran nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
echo "ran bash_completion"
nvm use $NPM_VERSION
echo "ran nvm command"
$HOME/.nvm/versions/node/v$NPM_VERSION/lib/node_modules/remix-ide/bin/remix-ide /app
