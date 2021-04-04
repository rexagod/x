package main

import (
	"errors"
	"fmt"
	"math"
)

func sqrt(n float64) (v float64, err error) {
	if n < 0 {
		err = errors.New("negative value")
	} else {
		v = math.Sqrt(n)
	}
	return
}

func main() {
	val, err := sqrt(-1)
	if err != nil {
		// handle error
		fmt.Println(err.Error()) // negative value
	} else {
		// all is good, use result
		fmt.Println(val)
	}
}
