# Password generator

Compiling the [`purescript`](http://www.purescript.org) code, supposing [`nvm`](http://nvm.sh) and `make` are already available, is as simple as typing:

    > nvm install --lts
    > npm install -g purescript
    > npm install -g spago
    > npm install -g parcel-bundler
    > npm install -g sass
    > make build


To run the application, just type:

    > make run

THis will start a web server serving the application on a local port, reported by [`ParcelJS`]() logs:

    >> starting...
    Server running at http://localhost:1234 
    ✨  Built in 2.36s.


If you want to have your application updated automatically when you edit your files (purs, js, html, scss), you can run (in a separate shell) the [`modd`](https://github.com/cortesi/modd) command
