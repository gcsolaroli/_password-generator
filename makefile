html: src/html/*.html
	mkdir -p "./output/.target/" && cp -R $? ./output/.target/

scss: src/scss/*.scss
	mkdir -p "./output/.target/scss" && cp -R $? ./output/.target/scss/

packages: spago.dhall packages.dhall
	spago install --jobs 10

PURESCRIPT: $(wildcard src/purescript/**/*.purs)

JAVASCRIPT: $(wildcard src/purescript/**/*.js)

compile: packages PURESCRIPT JAVASCRIPT
	spago bundle-app --to ./output/.target/js/index.js -- --output ./output --codegen js,sourcemaps --verbose-errors

build: html scss compile
	spago bundle-app --to ./output/.target/js/index.js -- --output ./output --codegen js,sourcemaps --verbose-errors

run: build
	parcel --out-dir ./output/.dist ./output/.target/index.html

clean: 
	rm -rf output
	rm -rf .spago
	rm -rf .sass-cache
	rm -rf .cache