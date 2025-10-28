**Un client trimite unui server un sir de numere. Serverul va returna clientului suma numerelor primite.**

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
	uint16_t n; ///nr de numere pe care le vom trimite
	uint16_t suma;
	uint16_t nr;
	c = socket(AF_INET, SOCK_STREAM, 0);
	if (c < 0){
		printf("Eroare la socket");
		return 1;
	}
	///configurare struct server
	memset(&server, 0, sizeof(server));
	server.sin_port = htons(1850);
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr("127.0.0.1");

	if(connect(c, (struct sockaddr*) &server, sizeof(server)) < 0){
		printf("Eroare la conectarea la server");
		return 1;
	}
	//cere de la user
	printf("Numarul de numere pentru suma: ");
	scanf("%hu", &n);
	n = htons(n);
	send(c, &n, sizeof(n), 0);
	
	for(int i = 0; i < ntons(n); i++){
		printf("Numar: ");
		scanf("%hu", &nr);
		nr  = htons(nr);
		send(c, &nr, sizeof(nr), 0);
	}

	recv(c, &suma, sizeof(suma), 0);
	suma = ntons(suma);
	printf("Suma este: %hu", suma);
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

int main(){
	int s;
	struct sockaddr_in server;
	struct sockaddr_in client;
	int c, l;
	
	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s < 0){
		printf("Eroare la crearea socketului!");
		return 1;
	}

	// Configurare structura server
	memset(&server, 0, sizeof(server)); 
	server.sin_port = htons(1850); 
	server.sin_family = AF_INET; 
	server.sin_addr.s_addr = INADDR_ANY;

	if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) { 
		printf("Eroare la bind\n"); 
		return 1; 
	}
	printf("Serverul este pregătit și așteaptă conexiuni...\n");
	listen(s, 5);
	l = sizeof(client);
	memset(&client, 0, sizeof(client));
	
	while(1){
		uint16_t n, nr, suma = 0;

		c = accept(s,(struct sockaddr *) &client, &l);
		printf("S-a conectat un client");
		recv(c, &n, sizeof(n), MSG_WAITALL);
		n = ntohs(n);
		
		for(int i = 0; i < n; i++){
			recv(c, &nr, sizeof(nr), MSG_WAITALL);
			nr = ntohs(nr);
			suma += nr;
		}
		suma = htons(suma);
		send(c, &suma, sizeof(suma), 0);
		close(c);
	}
	
}
```