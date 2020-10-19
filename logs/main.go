package main

import (
	"os"
	"time"

	"go.uber.org/zap"
)

func main() {
	z, _ := zap.NewProduction()
	log := z.Sugar()
	host, _ := os.Hostname()

	for {
		log.Infow("something happened", "host", host)
		time.Sleep(1 * time.Second)
	}
}
