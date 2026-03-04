
vc=~/www/valk2/valk
test:
	$(vc) build ./tests/*.valk ./tests --test -r
debug:
	$(vc) build ./tests/*.valk ./tests --test -r
