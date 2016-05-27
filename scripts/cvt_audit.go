package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"time"
)

var (
	usage    = "cvt_audit <audit log>"
	exitCode = 0
)

const (
	TYPE = iota + 1
	SEC
	NSEC
	SES
	MSG
)

func cvtAudit(filename string) {
	f, err := os.Open(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s Read Error!: %v\n", filename, err)
		exitCode = 1
		return
	}

	defer f.Close()

	scanner := bufio.NewScanner(f)
	re, err := regexp.Compile(`^type=(\S+) msg=audit\((\d+).(\d+):(\d+)\): (.+)`)
	if err != nil {
		f.Close()
		exitCode = 10
		return
	}
	for scanner.Scan() {
		line := scanner.Text()
		match := re.FindSubmatch([]byte(line))
		if match == nil {
			fmt.Println("Not Match")
			continue
		}

		sec, err := strconv.Atoi(string(match[SEC]))
		if err != nil {
			fmt.Println("Integer Convert Error %s: err")
			exitCode = 2
			return
		}
		nsec, err := strconv.Atoi(string(match[NSEC]))
		if err != nil {
			fmt.Println("Integer Convert Error %s: err")
			exitCode = 2
			return
		}

		t := time.Unix(int64(sec), int64(nsec)).UTC()

		fmt.Printf("type=%s msg=audit(%s:%s): %s\n", match[TYPE], t.String(), match[SES], match[MSG])
	}
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println(usage)
		exitCode = 1
	} else {
		cvtAudit(os.Args[1])
	}
	os.Exit(exitCode)
}
