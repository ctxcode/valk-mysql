
vc ?= valk

test:
	$(vc) build ./tests --test --run
test-basic:
	$(vc) build ./tests --test --run --filter "basic"
test-multi:
	$(vc) build ./tests --test --run --filter "multi"
example:
	$(vc) build ./example --run

.PHONY: test test-basic test-multi example
