Server concurent - limbaje diferite

**Clientul trimite serverului siruri de caractere pana cand acesta trimite "STOP" Serverul afiseaza pe ecran sirurile primite si de fiecare data ii raspunde acestuia cu sirul de caractere tradus in limba pasareasca.**
**Pentru a traduce un sir de caracter in limba pasareasca se foloseste regula:**
**dupa fiecare vocala din sir se pune caracteruk p urmat de vocala, astfel**
**A = pA**
**a = pa**
**E = pE**
**e = pe**
**i = pi**

**exemple**
**da = dapa**
**nu = nupu**

Server - Python

```python
import socket
import threading


def to_bird_language(sir):
    translated = ""
    for char in sir:
        if char.lower() in "aeiou":
            translated += char + "p" + char  
        else:
            translated += char
    return translated


def handle_client(client_socket, addr):
    print(f"Client conectat!:)")
    
    while True:
        # primeste mesajul de la client
        data = client_socket.recv(1024).decode()
        print(f"Am primit de la client ({addr}): {data}")

        # verifica daca mesajul este "STOP"
        if data == "STOP":
            print(f"Clientul de la {addr} a deconectat!!")
            break

        # traduce mesajul primit in limba pasareasca
        translated_message = to_bird_language(data)
        
        # trimite msg inapoi la client
        client_socket.send(translated_message.encode())
    client_socket.close()

# configurarea serverului - socket TCP
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('127.0.0.1', 1234))
server_socket.listen(5)  # 5 conexiuni in coada de asteptare
print("Serverul asculta la portul 1234...")

while True:
    # accepta conexiunea unui client (PI & port)
    client_socket, addr = server_socket.accept()
    
    # creeaza un nou fir pentru clientul conectat
    #functia si argumentele!!
    client_thread = threading.Thread(target=handle_client, args=(client_socket, addr))
    client_thread.start()  # pornim sirul


```

Client

```C
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>

int main() {
    int c;
    struct sockaddr_in server;
    char buffer[100];  // buffer pt sirul de caractere

    // crearea socketului
    c = socket(AF_INET, SOCK_STREAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    ///configurează structura server pentru conexiune
	///seteaza toti octetii stc server la 0 
	memset(&server, 0, sizeof(server));
	///seteaza portul 1234 convertit in format retea (big-endian) cu htons
	server.sin_port = htons(1234);
	///seteaza tipul adresarii la AF_INET(IPv4)
	server.sin_family = AF_INET;
	///seteaza adresa IP a serverului la localhost
	server.sin_addr.s_addr = inet_addr("127.0.0.1");

    // conectarea la server
    if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }

    while (1) {
        // citirea șirului de caractere de la utilizator
        printf("Introduceti un sir de caractere (sau STOP pentru a iesi): ");
        fgets(buffer, sizeof(buffer), stdin);
        buffer[strcspn(buffer, "\n")] = '\0';  // elimină '\n' de la final

        // trimite sirul -> il trimit si daca e stop si apoi o sa verfic
        send(c, buffer, strlen(buffer), 0);

        // caz: STOP
        if (strcmp(buffer, "STOP") == 0) {
            printf("Inchidere conexiune.\n");
            break;  
        }

        // primeste tradus de la server
        int len = recv(c, buffer, sizeof(buffer) - 1, 0);
        
        if (len > 0) {
            buffer[len] = '\0';  //adaugam term de sir '\0'
            printf("Raspuns de la server: %s\n", buffer);
        } else {
            printf("Eroare la primirea datelor de la server\n");
            break;
        }
    }
    close(c);
    return 0;
}

```