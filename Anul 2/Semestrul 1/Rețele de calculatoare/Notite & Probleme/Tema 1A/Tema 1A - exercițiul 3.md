**Un client trimite unui server un sir de caractere. Serverul va returna clientului acest sir oglindit (caracterele șirului in ordine inversa)..**

# C

!!!! ceva face figuri, nu știu ce are

Client

```C
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main(){
	int c;
	struct sockaddr_in server;
	char sir[256];

	c = socket(AF_INET, SOCK_STREAM, 0);
	if (c < 0){
		printf("Eroare la crearea socketului client\n");
		 return 1;
	}
	
	memset(&server, 0, sizeof(server)); 
	server.sin_port = htons(1851); // Portul serverului 
	server.sin_family = AF_INET; 
	server.sin_addr.s_addr = inet_addr("127.0.0.1"); 

	if(connect(c, (struct sockaddr *) &server, sizeof(server)) < 0){
		printf("Eroare la conectare");
		return 1;
	}
	printf("Introdu un sir de caractere: ");
	fgets(sir, sizeof(sir), stdin);
	sir[strcspn(sir, "\n")] = 0; // elim newline-ul la finalul șirului, dacă există

	///trimitem inclusiv terminatorul de sir '\0'
	send(c, sir, strlen(sir) + 1, 0); 

	recv(c, sir, sizeof(sir), 0);
	printf("Sirul oglindit primit de la server: %s\n", sir);
	close(c);
}
```

Server
```C
#include <sys/types.h> 
#include <sys/socket.h> 
#include <stdio.h>
#include <netinet/in.h> 
#include <netinet/ip.h>
#include <string.h> 
#include <stdlib.h>

void oglindesteSir(char *sir){
	int l = strlen(sir);
	for(int i = 0; i < l/2; i++){
		char temp = sir[i];
		sir[i] = sir[l - i - 1];
		sir[l - i - 1] = temp;
	}
}

int main(){
	int s;
	struct sockaddr_in server;
	struct sockaddr_in client;
	int c, l;

	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s < 0){
		printf("Eroare la crearea socketului");
		return 1;
	}
	// configurare structura server 
	memset(&server, 0, sizeof(server)); 
	server.sin_port = htons(1851); 
	server.sin_family = AF_INET; 
	server.sin_addr.s_addr = INADDR_ANY;

	if (bind(s, (struct sockaddr *)&server, sizeof(server)) < 0) { 
		printf("Eroare la bind\n");
		return 1; 
	}
	listen(s, 5);
	l = sizeof(client);
	memset(&client, 0, sizeof(client));

	while(1){
		char sir[256];
		c = accept(s, (struct sockaddr *) &client, &l);
		if (c < 0) { 
			printf("Eroare la acceptarea conexiunii cu clientul.\n"); 
			continue; 
		} 
		printf("S-a conectat un client\n");

		//primire sir de caractere de la client
		recv(c, sir, sizeof(sir), MSG_WAITALL);
		printf("Sir primit: %s\n", sir);

		oglindesteSir(sir);
		
		send(c, sir, strlen(sir) + 1, 0);
		close(c);
	}
	close(s);
}
```

# Python

Client

```Python
import socket
# IP si port
TCP_IP = "127.0.0.1"
TCP_PORT = 8888

sir = input("Enter the string: ")
#crearea unui socket TCP/IP
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#conecteaza la server utilizand adresa IP si portul
s.connect((TCP_IP, TCP_PORT))
# trimiterea sirului introdus de utilizator la server
#il codificam in format de bytes pt a-l trimite
s.send(sir.encode())

print("Sent to server: ", sir)

#primeste raspunsul de la server
data = s.recv(1024).decode()
print("Received form server:", str(data))

s.close()
```

Server

```Python
import socket

TCP_IP = "127.0.0.1"
TCP_PORT = 8888

# crearea unui socket TCP/IP
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# legarea socket-ului la adresa si portul specificat
server_socket.bind((TCP_IP, TCP_PORT))
# setarea serverului sa asculte conexiuni -> permite o conexiune
server_socket.listen(1)

while True:
    # accepta o conexiune noua de la client
    conn, addr = server_socket.accept()
    print('Connection from:', addr)  # optional: print the address of the client

    # primirea sirului de la client
    sir = conn.recv(100).decode()

    if not sir:  # verific daca sirul primit este gol
        print("Empty!")
        conn.close()  # close connection if empty
        continue  # skip to the next iteration of the while loop

    print('Received from client:', sir)

    # inversarea sirului
    sir_inversat = "".join(reversed(sir))
    
    # trimitem sirul inapoi la client
    conn.send(sir_inversat.encode())
    conn.close()  # close the connection after sending the response


```

