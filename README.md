# Password generator

Compiling the [`purescript`](http://www.purescript.org) code, supposing [`nvm`](http://nvm.sh) is already available, is as simple as typing:

    > nvm install --lts
    > npm install -g purescript
    > npm install -g spago
    > npm install -g parcel-bundler
    > spago install --jobs 10
    > spago bundle --to target/js/index.js


In order to run the full project you need a few extra tools:

  - [`modd`](https://github.com/cortesi/modd)
  - [`sass`](https://sass-lang.com/install)

With these tools installed, you can just run the `modd` command from inside the project folder, and the application will be available at running on a local port, reported by [`ParcelJS`]() logs:

    >> starting...
    Server running at http://localhost:1234 
    ✨  Built in 2.36s.


