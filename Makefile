
# vc=valk
vc=~/www/valk/valk

test:
	$(vc) build ./tests -t -r
test-basic:
	$(vc) build ./tests -t -r --filter "basic"
test-multi:
	$(vc) build ./tests -t -r --filter "multi"
example:
	cd example && vman install && $(vc) build main.valk -r

.PHONY: example
