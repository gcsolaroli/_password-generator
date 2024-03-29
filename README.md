# Password generator

## Initial setup e first build

Compiling the [`purescript`](http://www.purescript.org) code, supposing [`nvm`](http://nvm.sh) is already installed, is as simple as typing:

    > nvm install --lts (12.14.1)
    > npm install -g purescript@0.13.6
    > npm install -g spago@0.13.1
    > npm install -g parcel-bundler@1.12.4
    > npm install -g sass@1.25.0
    > npm install -g yarn@1.21.1
    > yarn clean; yarn build
    > yarn docs; open generated-docs/html/index.html
    > yarn develop-app


## VSCode integration

To support editing Purescript files, there are two useful VSCode plugins:
- PureScript IDE: https://github.com/nwolverson/vscode-ide-purescript
- PureScript Language Support: https://github.com/nwolverson/vscode-language-purescript

In order to have errors highlighted directly into VSCode, you need to set one option into the "PureScript IDE" module:
- "purescript.editorMode": true (Editor Mode: Whether to set the editor-mode flag on the IDE server)

To run the application, just type the following two commands in two different terminal windows:
- `yarn develop-purs`
- `yarn develop-app`

The first command will invoke `spago` to continuosly compile the PureScript files, while the second will start a web server to serve the application on a local port, reported by [`ParcelJS`]() logs:

    >> starting...
    Server running at http://localhost:1234 
    ✨  Built in 2.36s.
