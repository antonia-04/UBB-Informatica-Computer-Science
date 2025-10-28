**Se cere implementarea unui server concurent în Python și a unui client în C. Clientul va trimite un număr întreg către server, care va verifica dacă numărul este prim. Dacă numărul este prim, serverul va returna clientului același număr. Dacă nu este prim, serverul va calcula și va returna următorul număr prim. De exemplu, pentru input-ul „10”, serverul va răspunde cu „11”.**

###### Server

```python
import socket
import threading

# functie pentru a verifica daca un numar este prim
def is_prime(num):
    if num < 2:  # numerele mai mici decat 2 nu sunt prime
        return False
    for i in range(2, int(num**0.5) + 1):  # verifica divisibilitatea pana la radacina patrata a numarului
        if num % i == 0:
            return False  # numarul nu este prim
    return True  # numarul este prim

# functie pentru a gasi urmatorul numar prim
def next_prime(num):
    num += 1  # incepe de la urmatorul numar
    while not is_prime(num):  # continua pana gaseste un numar prim
        num += 1
    return num

# funcție care va gestiona fiecare conexiune client
def handle_client(client_socket):
    try:
        # primește datele de la client
        input_data = client_socket.recv(1024).decode().strip()  # primește șirul și elimină spațiile albe
        print(f"Received data: {input_data}")
        # verifica daca datele sunt un numar valid
        if input_data.isdigit():
            number = int(input_data)  # conversie la întreg daca e valid
            # verifica daca numarul este prim si genereaza raspunsul
            if is_prime(number):
                response = str(number)  # daca e prim, trimite numarul initial
            else:
                response = str(next_prime(number))  # altfel, trimite urmatorul numar prim
        else:
            response = "error: invalid input"  # trimite eroare daca inputul nu este valid

        client_socket.send(response.encode())  # trimite răspunsul înapoi clientului
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        client_socket.close()  # închide socket-ul client


# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # creeaza socket
server_socket.bind(('127.0.0.1', 1234))  # leaga serverul la IP si port
server_socket.listen(5)  # asculta pentru conexiuni

print("Server is listening on port 1234...")
while True:
    client_socket, addr = server_socket.accept()  # accepta conexiunea client
    print(f"Client connected from {addr}")

    # creeaza un fir nou pentru a deservi clientul
    client_thread = threading.Thread(target=handle_client, args=(client_socket,))
    client_thread.start()  # porneste firul

```

###### Client

```C
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>

int main() {
    int c;
    struct sockaddr_in server;
    char buffer[100];

    c = socket(AF_INET, SOCK_STREAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    memset(&server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }

    int number;
    printf("Introduceti un numar intreg: ");
    scanf("%d", &number);

    // trimite numarul ca sir de caractere catre server
    snprintf(buffer, sizeof(buffer), "%d", number);
    send(c, buffer, strlen(buffer), 0);

    // primeste raspunsul de la server
    int len = recv(c, buffer, sizeof(buffer) - 1, 0);
    if (len > 0) {
        buffer[len] = '\0';  // terminator de sir
        printf("Raspuns de la server: %s\n", buffer);
    } else {
        printf("Eroare la primirea datelor de la server\n");
    }

    close(c);
    return 0;
}

```
