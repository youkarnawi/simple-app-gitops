FROM busybox

CMD ["sh", "-c", "while true; do echo -e \"HTTP/1.1 200 OK\r\n\r\nYOUUUUUUSSSSSEEEEEFFFFF\" | nc -l -p 8080; done"]
