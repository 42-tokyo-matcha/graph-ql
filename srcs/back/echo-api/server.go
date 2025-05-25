package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/labstack/echo/v4"

	_ "github.com/go-sql-driver/mysql"
)

func helloWorldHandler(c echo.Context) error {
	sendEmail()
	return c.String(http.StatusOK, "Hello, World!")
}

func main() {
	// データベースに接続
	db, err := connectDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()


	message := os.Getenv("SAMPLE_MESSAGE")

	fmt.Println("SAMPLE_MESSAGE", message)
	e := echo.New()
	g := e.Group("/api")
	g.GET("/", helloWorldHandler)

	e.Logger.Fatal(e.Start(":3000"))
}
