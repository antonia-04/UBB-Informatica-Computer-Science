**Un client trimite unui server un sir de caractere. Serverul va returna clientului numarul de caractere spatiu din sir.**

Client

```python
import socket

TCP_IP = "127.0.0.1"
TCP_PORT = 8888

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))

SIR_CARACTERE = input("Dati un sir de caractere: ")
s.send(SIR_CARACTERE.encode())
print("Am trimis la server: ", SIR_CARACTERE)

nr = s.recv(10).decode()
print("Am primit de la server: ", nr)

s.close()

print("Sirul de caractere: " + SIR_CARACTERE + " are " + nr + " spatii")
```

Server

```python
import socket

TCP_IP = "127.0.0.1"
TCP_PORT = 8888

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((TCP_IP, TCP_PORT))
s.listen(1)

nr = 0

while 1:
    conn, addr = s.accept()
    print("Connection address: ", addr)
    data = conn.recv(100)
    if not data: break
    print("Am primit de la client: ", data.decode())
    for el in data.decode():
        if el == " ":
            nr = nr + 1
    print("Am trimis la client: ", nr)
    conn.send(str(nr).encode())
conn.close()
```