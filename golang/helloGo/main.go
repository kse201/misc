package main

import (
	"fmt"

	cls "./lib/cls"
)

func main() {
	kls := cls.Cls{Msg: "Golang"}
	fmt.Println(kls.Message())
	fmt.Println(kls.Execute())
}
