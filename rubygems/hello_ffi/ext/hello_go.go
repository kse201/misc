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
func main() {
}
