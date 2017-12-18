package cls

import (
	"os/exec"
)

// Cls is hello class
type Cls struct {
	Msg string
}

// Message return message
func (client *Cls) Message() string {
	return "Hello " + client.Msg
}

// GetArray is great function
func (client Cls) GetArray() []int {
	return []int{1, 2}
}

// Execute is awesome function
func (client Cls) Execute() string {
	cmd := exec.Command("ls", "-la")

	out, err := cmd.Output()
	if err != nil {
		panic("command error")
	}

	return string(out)
}
