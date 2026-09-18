
vc ?= valk

deps:
	vman install
server:
	./tests/server.sh up
server-down:
	./tests/server.sh down
test:
	$(vc) build ./tests --test --run
test-basic:
	$(vc) build ./tests --test --run --filter "basic"
test-multi:
	$(vc) build ./tests --test --run --filter "multi"
example:
	$(vc) build ./example --run

.PHONY: server server-down deps test test-basic test-multi example
