package main

/*
#cgo LDFLAGS: -ldl
#include <dlfcn.h>

void call_func(void* p) {
    void (*func)() = p;
    func();
}
*/
import "C"

func main() {
	handle := C.dlopen(C.CString("./shared/hello.so"), C.RTLD_LAZY)
	if handle == nil {
		panic("Failed dlopen")
	}
	defer C.dlclose(handle)

	hello := C.dlsym(handle, C.CString("hello"))
	if hello == nil {
		panic("failed dlsym")
	}
	C.call_func(hello)
}
