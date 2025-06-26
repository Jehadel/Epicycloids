run:
	love src/

love:
	mkdir -p dist
	cd src && zip -r ../dist/epicycloid-demo.love .

js: love
	love.js -c --title="Epicycloid - polar coorodinates demo" ./dist/epicycloid-demo.love ./dist/js
