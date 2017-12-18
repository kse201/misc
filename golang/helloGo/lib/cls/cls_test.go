package cls

import (
	"testing"
)

func TestCls(t *testing.T) {
	subject := Cls{Msg: "test"}
	actual := subject.Message()

	if actual != "Hello test" {
		t.Error("Wrong message!:", actual)
	}
}

func TestArray(t *testing.T) {
	subject := Cls{Msg: "test"}
	actual := subject.GetArray()
	expect := []int{1, 2}

	if len(actual) == len(expect) {
		for i, v := range actual {
			if v != expect[i] {
				t.Error("Wrong array!:", actual)
			}
		}
	} else {
		t.Error("Wrong array!:", actual)
	}
}

func TestExecute(t *testing.T) {
	subject := Cls{Msg: "test"}

	output := subject.Execute()

	t.Log(output)
}
