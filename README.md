# Password generator

Compiling the [`purescript`](http://www.purescript.org) code, supposing [`nvm`](http://nvm.sh) is already available, is as simple as typing:

    > nvm install --lts
    > npm install -g purescript
    > npm install -g spago
    > spago install --jobs 10
    > spago bundle --to target/js/index.js


In order to run the full project you need a few extra tools:

  - [`modd`](https://github.com/cortesi/modd)
  - [`devd`](https://github.com/cortesi/devd)
  - [`sass`](https://sass-lang.com/install)

With these tools installed, you can just run the `modd` command from inside the project folder, and the application will be available at this [url](http://devd.io:8000/)