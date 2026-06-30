
vc=valk
# vc=~/www/valk2/valk

test:
	$(vc) build ./tests/*.valk ./tests --test -r --clean
example:
	cd example && vman install && $(vc) build main.valk -r

.PHONY: example
