package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	res, err := http.Get(fmt.Sprintf("%s://%s:%s/%s",
		getEnvironmentVariable("HEALTH_CHECK_HTTP", "http"),
		getEnvironmentVariable("HEALTH_CHECK_HTTP_BASE_URL", "localhost"),
		getEnvironmentVariable("HEALTH_CHECK_HTTP_PORT", "80"),
		getEnvironmentVariable("HEALTH_CHECK_HTTP_ROUTE", "health")))
	if err != nil || (res.StatusCode < 200 || res.StatusCode > 299) {
		fmt.Println(err)
		os.Exit(1)
	}
}

//GetEnvironmentVariable attempts to get an environment variable.
//If no environment variable is set, it will return the fallback
func getEnvironmentVariable(key string, fallback string) string {
	if variable := os.Getenv(key); variable != "" {
		return variable
	}
	return fallback
}
