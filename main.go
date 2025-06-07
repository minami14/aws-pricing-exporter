package main

import (
	"log"
	"log/slog"
	"net/http"
	"os"

	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/prometheus/exporter-toolkit/web"
)

func main() {
	http.Handle("/metrics", promhttp.Handler())
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("<html><head><title>AWS Pricing Exporter></title></head><body><h1>AWS Pricing Exporter</h1><p><a href='/metrics'>Metrics</a></p></body></html>"))
	})
	systemdSocket := false
	configFile := ""
	webConfig := &web.FlagConfig{
		WebListenAddresses: &[]string{":8080"},
		WebSystemdSocket:   &systemdSocket,
		WebConfigFile:      &configFile,
	}
	if err := web.ListenAndServe(&http.Server{}, webConfig, slog.New(slog.NewTextHandler(os.Stdout, nil))); err != nil {
		log.Fatal(err)
	}
}
