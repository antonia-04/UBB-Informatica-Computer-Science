## Tema 1A

***Exemplu

```C
#include <sys/types.h>  -> definitii pt functii si tipuri legate de socketuri
#include <sys/socket.h> -> definitii pt functii si tipuri legate de socketuri
#include <stdio.h>      -> I/O in C printf, scanf
#include <netinet/in.h> -> contin definiții pt str de adresare de retea
#include <netinet/ip.h> -> contin definiții pt str de adresare de retea
#include <string.h>
```

**Client**

```C
int main() {

  int c; ///SOCKETUL CLIENT
  
  ///structura care contine informatii despre server (IP & port)
  struct sockaddr_in server; 
  ///uint16_t variabile pe 16 biti 
  uint16_t a, b, suma;
  ///creeaza un socket TCP/IP
  /// `AF_INET` indică folosirea IPv4
  /// `SOCK_STREAM` specifică că este un socket de tip TCP.
  c = socket(AF_INET, SOCK_STREAM, 0);
  ///dacă returnează < 0 eșuează
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
  ///stabilește conexiunea cu serverul folosind info din struct server
  if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {

    printf("Eroare la conectarea la server\n");

    return 1;

  }
  //dupa ce s-a conectat cere datele de la client
  printf("a = ");

  scanf("%hu", &a);

  printf("b = ");

  scanf("%hu", &b);
  ///converteste la big-endian
  a = htons(a);

  b = htons(b);
  /// trimite valorile catre server
  send(c, &a, sizeof(a), 0);

  send(c, &b, sizeof(b), 0);
  ///primeste de la server suma
  recv(c, &suma, sizeof(suma), 0);
  ///converteste in format gazda (little-endian)
  suma = ntohs(suma);

  printf("Suma este %hu\n", suma);
  ///inchide conexiunea
  close(c);

}
```

**Server**

->  [[Server concurent C - proceduri]]

```C
int main() {
  ///socket server
  int s;
  ///structuri care contin informatii despre adresele serverului si clientului
  struct sockaddr_in server;
  struct sockaddr_in client;
  /// c = socketul pentru conexiunea clientului
  /// l = lungimea struct client
  int c, l;
  ///creeaza socketul de tip TCP/IP
  s = socket(AF_INET, SOCK_STREAM, 0);

  if (s < 0) {
    printf("Eroare la crearea socketului server\n");
    return 1;
  }
  ///creeaza socketul server
  ///seteaza toti octetii din server la 0
  memset(&server, 0, sizeof(server));
  ///seteaza portul 1234 convertit in format retea (big-endian) cu htons
  server.sin_port = htons(1234);
  ///seteaza tipul adresarii la AF_INET(IPv4)
  server.sin_family = AF_INET;
  ///permite serverului sa fie accesibil de la orice adresa IP disponibila pe care o deține dispozitivul
  server.sin_addr.s_addr = INADDR_ANY;
  ///configureaza structura server
  if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
    printf("Eroare la bind\n");
    return 1;
  }
  ///pune serverul in modul de ascultate si permite o coada de pana la 5 conexiuni
  listen(s, 5);
  l = sizeof(client);
  ///seteaza toti octetii din client la 0
  memset(&client, 0, sizeof(client));
  
  while (1) {

    uint16_t a, b, suma;
	///blocheaza executia serverului pana se conecteaza un client
    c = accept(s, (struct sockaddr *) &client, &l);

    printf("S-a conectat un client.\n");

    // deservirea clientului

    recv(c, &a, sizeof(a), MSG_WAITALL);

    recv(c, &b, sizeof(b), MSG_WAITALL);
    ///ntons converteste valorile in format gazda (little-endian)
    a = ntohs(a);
    b = ntohs(b);

    suma = a + b;
    ///converteste suma in format retea(big-endian)
    suma = htons(suma);

    send(c, &suma, sizeof(suma), 0);

    close(c);
    // sfarsitul deservirii clientului;
  }
}
```

##### Cerințe
1. [x] Un client trimite unui server un sir de numere. Serverul va returna clientului suma numerelor primite.
2. [x] [ ] Un client trimite unui server un sir de caractere. Serverul va returna clientului numarul de caractere spatiu din sir.
3. [x] Un client trimite unui server un sir de caractere. Serverul va returna clientului acest sir oglindit (caracterele sirului in ordine inversa).
4. [ ] Un client trimite unui server doua siruri de caractere ordonate. Serverul va interclasa cele doua siruri si va returna clientului sirul rezultat interclasat.
5. [ ] Un client trimite unui server un numar. Serverul va returna clientului sirul divizorilor acestui numar.
6. [ ] Un client trimite unui server un sir de caractere si un caracter. Serverul va returna clientului toate pozitiile pe care caracterul primit se regaseste in sir.
7. [ ] Un client trimite unui server un sir de caractere si doua numere (fie acestea s, i, l). Serverul va returna clientului subsirul de lungime l a lui s care incepe la pozitia i.
8. [ ] Un client trimite unui server doua siruri de numere. Serverul va returna clientului sirul de numere comune celor doua siruri primite.
9. [ ] Un client trimite unui server doua siruri de numere. Serverul va returna clientului sirul de numere care se regaseste in primul sir dar nu se regasesc in al doilea.
10. [ ] Un client trimite unui server doua siruri de caractere. Serverul ii raspunde clientului cu caracterul care se regaseste de cele mai multe ori pe pozitii identice in cele doua siruri si cu numarul de aparitii ale acestui caracter.

#### Rezolvări
[[Tema 1A - exercițiul 1]]
[[Tema 1A - exercițiul 3]]
