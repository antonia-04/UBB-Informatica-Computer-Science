#### Server UDP - secvențial

```python
import socket

# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # creeaza un socket UDP
server_socket.bind(('127.0.0.1', 1234))  # leaga socket-ul la IP si port

print("serverul asteapta mesaje...")

while True:
    input_data, addr = server_socket.recvfrom(1024)  # primeste date de la client
    print(f"date primite de la {addr}: {input_data.decode()}")
    
    response = f"echo: {input_data.decode()}"  # pregateste raspunsul
    server_socket.sendto(response.encode(), addr)  # trimite raspunsul inapoi clientului
```
#### Server UDP - concurent

```python
import socket
import threading

# functie pentru a gestiona fiecare mesaj de client
def handle_client(data, addr):
    print(f"date primite de la {addr}: {data.decode()}")
    response = f"echo: {data.decode()}"  # pregateste raspunsul
    server_socket.sendto(response.encode(), addr)  # trimite raspunsul inapoi clientului

# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # creeaza un socket UDP
server_socket.bind(('127.0.0.1', 1234))  # leaga socket-ul la IP si port

print("serverul asteapta mesaje...")

while True:
    input_data, addr = server_socket.recvfrom(1024)  # primeste date de la client
    client_thread = threading.Thread(target=handle_client, args=(input_data, addr))  # creeaza un fir pentru client
    client_thread.start()  # porneste firul

```
#### Client UDP

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>

int main() {
    int sock;
    struct sockaddr_in server;
    char message[100], server_reply[200];

    // creeaza socket
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock == -1) {
        printf("eroare la crearea socketului\n");
        return 1;
    }

    server.sin_addr.s_addr = inet_addr("127.0.0.1");  // setez IP
    server.sin_family = AF_INET;  // setez tipul de adresa
    server.sin_port = htons(1234);  // setez portul

    printf("introduceti mesajul: ");
    scanf("%s", message);  // citeste mesajul de la utilizator

    // trimite mesajul
    sendto(sock, message, strlen(message), 0, (struct sockaddr*)&server, sizeof(server));
    
    // primeste raspunsul
    socklen_t server_len = sizeof(server);
    recvfrom(sock, server_reply, sizeof(server_reply), 0, (struct sockaddr*)&server, &server_len);
    printf("raspunsul de la server: %s\n", server_reply);

    close(sock);  // inchide socketul
    return 0;
}

```