package cls

type Cls struct {
	Msg string
}

func (this *Cls) Message() string {
	return "Hello " + this.Msg
}
