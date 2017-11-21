LIBRARY_PATH = ./shared
LDFLAGS =-ldl

CLEAN = ./_obj ./build ./shared
so-go:
	go build -buildmode=c-shared -o ./shared/hello.so lib/hello.go

so-c:
	gcc -shared -o ./shared/hello.so lib/hello.c

run-go:
	go run src/main.go

run-c:
	gcc -I./shared -L./shared -o build/c src/main.c ./shared/hello.so
	./build/c

clean:
	rm -rf $(CLEAN)
