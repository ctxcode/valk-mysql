
# vc=valk
vc=~/www/valk/valk

test:
	$(vc) build ./tests -t -r
test-basic:
	$(vc) build ./tests -t -r --filter "query"
example:
	cd example && vman install && $(vc) build main.valk -r

.PHONY: example
