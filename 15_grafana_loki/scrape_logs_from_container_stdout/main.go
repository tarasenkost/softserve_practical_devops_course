package main

import (
    "github.com/labstack/echo/v4"
    "github.com/labstack/echo/v4/middleware"
    "io"
    "os"
    "webapp/pkg/config"
)

func main() {
    port := config.GetEnv("PORT", "8080")
    logPath := config.GetEnv("LOG_PATH", "/var/log/webapp.log")

    e := echo.New()

    logFile, err := os.OpenFile(logPath, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
    if err != nil {
        e.Logger.Fatal("Unable to open log file:", err)
    }

    multiWriter := io.MultiWriter(logFile, os.Stdout)

    e.Logger.SetOutput(multiWriter)

    e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
        Format: `${remote_ip} [${time_custom}] "${method} ${uri} ${protocol}" ${status} ${bytes_out} ${latency_human} ${user_agent}` + "\n",
        CustomTimeFormat: "2006-01-02 15:04:05",
        Output: multiWriter,
    }))

    e.Static("/", "public")

    e.GET("/", func(c echo.Context) error {
        return c.File("public/views/webapp.html")
    })

    if err := e.Start(":" + port); err != nil {
        e.Logger.Fatal("Shutting down the server")
    }

    logFile.Close()
}
