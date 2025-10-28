**Se cere implementarea unui server concurent în Python și a unui client în C. Clientul va trimite un număr întreg către server, care va verifica dacă numărul este „echilibrat”. Un număr este considerat echilibrat dacă suma cifrelor de pe pozițiile pare este egală cu suma cifrelor de pe pozițiile impare.**

**Dacă numărul este echilibrat, serverul va returna clientului același număr. Dacă nu este echilibrat, serverul va calcula și trimite următorul număr echilibrat. De exemplu, pentru input-ul „130”, serverul va răspunde cu „132”.**

###### Server

```Python
import socket
import threading

# funcție pentru a verifica dacă un număr este echilibrat
def is_balanced(number):
    even_sum = 0
    odd_sum = 0
    str_number = str(number)

    for i in range(len(str_number)):
        digit = int(str_number[i])  # obține cifra
        if i % 2 == 0:
            even_sum += digit  # suma cifrelor pe poziții pare
        else:
            odd_sum += digit  # suma cifrelor pe poziții impare

    return even_sum == odd_sum  # compară sumele

# funcție pentru a găsi următorul număr echilibrat
def get_next_balanced(number):
    number += 1  # începe de la următorul număr
    while not is_balanced(number):
        number += 1  # continuă până găsește un număr echilibrat
    return number

# funcție care va gestiona fiecare conexiune
def handle_client(client_socket):
    try:
	    # primește datele de la client
        input_data = client_socket.recv(1024).decode()  
        number = int(input_data)  # convertește în întreg
        print(f"Received number: {number}")

        # verifică dacă numărul este echilibrat
        if is_balanced(number):
            response = str(number)  # trimite numărul înapoi
        else:
	        # trimite următorul număr echilibrat
            response = str(get_next_balanced(number))  

        client_socket.send(response.encode())  # trimite răspunsul
    finally:
        client_socket.close()  # închide socket-ul client

# Configurarea serverului
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('127.0.0.1', 1234))  # leagă serverul la IP și port
server_socket.listen(5)  # ascultă pentru conexiuni

print("Server is listening on port 1234...")
while True:
    client_socket, addr = server_socket.accept()  # acceptă conexiunea
    print(f"Client connected from {addr}")
    client_thread = threading.Thread(target=handle_client, args=(client_socket,))
    client_thread.start()  # pornește un fir nou pentru a gestiona clientul

```

###### Client

```C
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <stdlib.h>  // pentru atoi

int main() {
    int c;
    struct sockaddr_in server;
    char buffer[100];

    // crearea socket-ului client
    c = socket(AF_INET, SOCK_STREAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    // inițializarea structurii server
    memset(&server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    // conectarea la server
    if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }

    // cererea de introducere a unui număr de la utilizator
    printf("Dati un numar: ");  
    fgets(buffer, 100, stdin); // citirea numărului introdus
    send(c, buffer, strlen(buffer), 0); // trimiterea numărului către server

    // primirea răspunsului de la server
    memset(buffer, 0, sizeof(buffer)); // resetarea buffer-ului
    recv(c, buffer, sizeof(buffer), 0); // primirea răspunsului
    printf("Received from server: %s\n", buffer); // afișarea rezultatului

    close(c); // închiderea socket-ului client
    return 0;
}
```
