package main

import (
	"fmt"

	cls "./lib/cls"
)

func adverseEffectFunc(a *int) error {
	*a++
	return nil
}

func foo() string {
	var str string

	return str
}

func main() {
	kls := cls.Cls{Msg: "Golang"}
	fmt.Println(kls.Message())
	fmt.Println(kls.Execute())

	v := foo()
	pointer := &v

	v = "hogehoge"
	fmt.Println("The address of v: ", &v)
	fmt.Println("pointer: ", pointer)
	fmt.Println("The value of v: ", v)
	fmt.Println("The internal value of pointer: ", *pointer)

	a := 1
	fmt.Println("the value of a: ", a)
	adverseEffectFunc(&a)
	fmt.Println("the value of a: ", a)

}
