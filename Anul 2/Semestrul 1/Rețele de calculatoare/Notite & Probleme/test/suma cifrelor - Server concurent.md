**Se cere implementarea unui server concurent în Python și a unui client în C. Clientul va trimite un număr întreg către server, care va calcula suma cifrelor numărului. Serverul va returna clientului suma calculată. De exemplu, pentru input-ul „456”, serverul va răspunde cu „15” (4 + 5 + 6).**

###### Server

```python
import socket
import threading

# funcție pentru a calcula suma cifrelor unui număr
def sum_of_digits(number):
    return sum(int(digit) for digit in str(number))

# funcție care va gestiona fiecare conexiune cu clientul
def handle_client(client_socket):
    try:
        # primește datele de la client
        input_data = client_socket.recv(1024).decode().strip()  # elimină spațiile suplimentare
        print(f"Received number: {input_data}")

        # verifică dacă input-ul primit este numeric
        if input_data.isdigit():
            number = int(input_data)
            result = sum_of_digits(number)  # calculează suma cifrelor
            response = str(result)  # convertește rezultatul în șir pentru a fi trimis înapoi
        else:
            response = "error: invalid input"  # mesaj de eroare dacă nu e număr

        # trimite răspunsul înapoi clientului
        client_socket.send(response.encode())
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        client_socket.close()  # închide conexiunea cu clientul

# configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # creează socket TCP
server_socket.bind(('127.0.0.1', 1234))  # leagă serverul la IP-ul local și portul 1234
server_socket.listen(5)  # permite până la 5 conexiuni în coada de așteptare

print("Server is listening on port 1234...")
while True:
    client_socket, addr = server_socket.accept()  # acceptă conexiunea de la un client
    print(f"Client connected from {addr}")

    # creează și pornește un nou thread pentru fiecare client
    client_thread = threading.Thread(target=handle_client, args=(client_socket,))
    client_thread.start()  # rulează funcția handle_client în thread separat

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

    // crearea socketului
    c = socket(AF_INET, SOCK_STREAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    // configurarea adresei serverului
    memset(&server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    // conectarea la server
    if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }

    // citirea numărului de la utilizator
    int number;
    printf("Introduceti un numar intreg: ");
    scanf("%d", &number);

    // convertirea numărului la șir și trimiterea către server
    snprintf(buffer, sizeof(buffer), "%d", number);
    send(c, buffer, strlen(buffer), 0);

    // primirea răspunsului de la server
    int len = recv(c, buffer, sizeof(buffer) - 1, 0);
    if (len > 0) {
        buffer[len] = '\0';  // adaugă terminatorul de șir
        printf("Raspuns de la server: %s\n", buffer);
    } else {
        printf("Eroare la primirea datelor de la server\n");
    }

    // închiderea conexiunii
    close(c);
    return 0;
}

```

