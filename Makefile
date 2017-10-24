
compile:
	rsync -r src/static/ target
	elm-make src/elm/Pastor.elm --output target/js/pastor.js

clean:
	rm -rf target

dist-clean: clean
	rm -rf elm-stuff

