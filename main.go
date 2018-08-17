package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
)

type Output struct {
	Args []string          `json:"args"`
	Env  map[string]string `json:"env"`
}

func main() {
	out := Output{
		Args: os.Args,
		Env:  make(map[string]string),
	}

	for _, e := range os.Environ() {
		pair := strings.SplitN(e, "=", 2)
		out.Env[pair[0]] = pair[1]
	}

	err := json.NewEncoder(os.Stdout).Encode(&out)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
