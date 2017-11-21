package main

// #include <stdio.h>
import "C"

import "fmt"

//export hello
func hello() {
	fmt.Println("Hello Go shared library")
}

func main() {

}
