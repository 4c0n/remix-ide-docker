#!/bin/bash
export NVM_DIR="$HOME/.nvm"
echo "exported"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo "ran nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
echo "ran bash_completion"
nvm use 10.10.0
echo "ran nvm command"
$HOME/.nvm/versions/node/v10.10.0/lib/node_modules/remix-ide/bin/remix-ide /app
