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
