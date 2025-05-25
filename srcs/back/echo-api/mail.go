package main

import (
	"fmt"
	"net/smtp"
	"os"
	"strings"
)

var (
	hostname = "mailhog" // docker-composeで指定したサービス名
	port     = 1025      // mailhogのSMPTポート
	username = "user@example.com"
	password = "password"
	from     = "from@example.net"
	subject  = "hello"
	body     = "Hello World!"
	receiver = []string{"receiver@example.com"}
)

func sendEmail() {
	fmt.Println("sendEmail()")

	smtpServer := fmt.Sprintf("%s:%d", hostname, port)
	auth := smtp.CRAMMD5Auth(username, password)
	msg := []byte(fmt.Sprintf("To: %s\nSubject: %s\n\n%s", strings.Join(receiver, ","), subject, body))

	if err := smtp.SendMail(smtpServer, auth, from, receiver, msg); err != nil {
		fmt.Fprintln(os.Stderr, err)
	}
}
