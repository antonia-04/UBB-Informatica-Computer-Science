**Se cere implementarea unui server concurent în Python și a unui client în C. Clientul va trimite un șir de caractere către server, care va verifica dacă șirul este un palindrom (se citește la fel de la stânga la dreapta și de la dreapta la stânga).** 
**Dacă șirul este palindrom, serverul va returna același șir. Dacă nu este palindrom, serverul va trimite șirul inversat.** 
**De exemplu, pentru input-ul „radar”, serverul va răspunde cu „radar”, iar pentru „hello”, va răspunde cu „olleh”.**

###### Server - procese

```Python
import socket
import os

# funcție pentru a verifica dacă un șir este palindrom
def is_palindrome(s):
    return s == s[::-1]  # compară șirul cu versiunea sa inversată

# funcție care va gestiona fiecare conexiune client
def handle_client(client_socket):
    try:
        # primește datele de la client
        input_data = client_socket.recv(1024).decode()  # primește șirul
        print(f"Received string: {input_data}")

        # verifică dacă șirul este palindrom
        if is_palindrome(input_data):
            response = input_data  # dacă este palindrom, trimite înapoi șirul original
        else:
            response = input_data[::-1]  # dacă nu este, trimite șirul inversat

        client_socket.send(response.encode())  # trimite răspunsul înapoi clientului
    finally:
        client_socket.close()  # închide socket-ul client

# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # creează socket
server_socket.bind(('127.0.0.1', 1234))  # leagă serverul la IP și port
server_socket.listen(5)  # ascultă pentru conexiuni

print("Server is listening on port 1234...")
while True:
    client_socket, addr = server_socket.accept()  # acceptă conexiunea client
    print(f"Client connected from {addr}")

    # creează un nou proces pentru a deservi clientul
    pid = os.fork()  # creează un proces fiu
    if pid == 0:  # dacă este procesul fiu
        server_socket.close()  # închide socket-ul server în procesul fiu
        handle_client(client_socket)  # deserveste clientul
        os._exit(0)  # termină procesul fiu
    else:
        client_socket.close()  # închide socket-ul client în procesul părinte

```

###### Server - threads

```python
import socket
import os

# funcție pentru a verifica dacă un șir este palindrom
def is_palindrome(s):
    return s == s[::-1]  # compară șirul cu versiunea sa inversată

# funcție care va gestiona fiecare conexiune client
def handle_client(client_socket):
    try:
        # primește datele de la client
        input_data = client_socket.recv(1024).decode()  # primește șirul
        print(f"Received string: {input_data}")

        # verifică dacă șirul este palindrom
        if is_palindrome(input_data):
            response = input_data  # dacă este palindrom, trimite înapoi șirul original
        else:
            response = input_data[::-1]  # dacă nu este, trimite șirul inversat

        client_socket.send(response.encode())  # trimite răspunsul înapoi clientului
    finally:
        client_socket.close()  # închide socket-ul client

# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # creează socket
server_socket.bind(('127.0.0.1', 1234))  # leagă serverul la IP și port
server_socket.listen(5)  # ascultă pentru conexiuni

print("Server is listening on port 1234...")
while True:
    client_socket, addr = server_socket.accept()  # acceptă conexiunea client
    print(f"Client connected from {addr}")

    # creează un nou proces pentru a deservi clientul
    pid = os.fork()  # creează un proces fiu
    if pid == 0:  # dacă este procesul fiu
        server_socket.close()  # închide socket-ul server în procesul fiu
        handle_client(client_socket)  # deserveste clientul
        os._exit(0)  # termină procesul fiu
    else:
        client_socket.close()  # închide socket-ul client în procesul părinte

```

###### Client

```C
#include <sys/types.h> // include tipuri de date
#include <sys/socket.h> // include funcții pentru socket-uri
#include <stdio.h> // include funcții pentru intrare/ieșire
#include <netinet/in.h> // include structuri pentru rețea
#include <string.h> // include funcții pentru manipularea string-urilor
#include <unistd.h> // include funcții POSIX, cum ar fi close

int main() {
    int sock; // descriptorul de socket
    struct sockaddr_in server; // structura pentru adresa serverului
    char buffer[1024]; // buffer pentru mesajul de trimis
    char response[1024]; // buffer pentru răspunsul serverului

    // crearea socket-ului
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) { // verificare eroare
        printf("Eroare la crearea socket-ului\n");
        return 1;
    }

    // configurarea adresei serverului
    memset(&server, 0, sizeof(server)); // setează structura la zero
    server.sin_family = AF_INET; // familie de adrese IPv4
    server.sin_port = htons(1234); // portul serverului
    server.sin_addr.s_addr = inet_addr("127.0.0.1"); // adresa IP a serverului

    // conectarea la server
    if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }

    // citirea șirului de la utilizator
    printf("Introdu un șir: ");
    fgets(buffer, sizeof(buffer), stdin); // citește șirul

    // trimite șirul la server
    send(sock, buffer, strlen(buffer) - 1, 0); // trimite șirul fără newline

    // primește răspunsul de la server
    recv(sock, response, sizeof(response), 0);
    printf("Răspuns de la server: %s\n", response); // afișează răspunsul

    close(sock); // închide socket-ul
    return 0; // termină programul
}

```