
vc=~/www/valk2/valk
test:
	$(vc) build ./tests/*.valk ./tests --test -r
debug:
	$(vc) build ./tests/*.valk ./tests --test -r
example:
	cd example && vman install github.com/ctxcode/valk-mysql && valk build main.valk -r

.PHONY: example
