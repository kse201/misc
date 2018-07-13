package main

// #include <stdio.h>

import (
	"C"
	"fmt"
)

//export hello
func hello() {
	fmt.Println("Hello Go Shared Library")
}

//export write_bar
func write_bar() string {
	fStr := "FOO by Go shared library\n\n"
	return fStr
}

func main() {
}
