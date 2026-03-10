
vc=~/www/valk2/valk

test:
	$(vc) build ./tests/*.valk ./tests --test -r
example:
	cd example && vman install && $(vc) build main.valk -r

.PHONY: example
