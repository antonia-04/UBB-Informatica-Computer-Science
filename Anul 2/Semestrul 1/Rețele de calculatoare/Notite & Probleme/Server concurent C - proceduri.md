

```C
#include <sys/types.h> 
#include <sys/socket.h> 
#include <stdio.h> 
#include <netinet/in.h> 
#include <netinet/ip.h> 
#include <string.h> 

// funcție care deserveste fiecare client
void deservire_client(int c) {
    // declararea variabilelor pentru datele primite
    uint16_t a, b, suma;
    
    // primește primele două numere de la client
    recv(c, &a, sizeof(a), MSG_WAITALL); // primește primul număr
    recv(c, &b, sizeof(b), MSG_WAITALL); // primește al doilea număr
    
    // conversia numelui de rețea în ordinea gazdelor
    a = ntohs(a); // conversia numărului din rețea în ordinea gazdelor
    b = ntohs(b); // conversia numărului din rețea în ordinea gazdelor
    
    // calcularea sumei celor două numere
    suma = a + b; // suma numerelor primite
    suma = htons(suma); // conversia sumei în ordinea rețelei

    // trimiterea sumei înapoi clientului
    send(c, &suma, sizeof(suma), 0); // trimite suma înapoi
    close(c); // închide socket-ul client
    // sfârșitul deservirii clientului
}

int main() {
    int s; // descriptorul de socket pentru server
    struct sockaddr_in server, client; // structuri pentru adresa serverului și clientului
    int c, l; // variabile pentru conexiunea client și lungimea structurii client

    // crearea socket-ului pentru server
    s = socket(AF_INET, SOCK_STREAM, 0); // creează un socket TCP
    if (s < 0) { // verifică dacă socket-ul a fost creat cu succes
        printf("Eroare la crearea socketului server\n"); // mesaj de eroare
        return 1; // termină programul în caz de eroare
    }

    // inițializarea structurii server
    memset(&server, 0, sizeof(server)); // setează toată structura la zero
    server.sin_port = htons(1234); // setează portul serverului
    server.sin_family = AF_INET; // setează familia de adrese la IPv4
    server.sin_addr.s_addr = INADDR_ANY; // acceptă conexiuni de la orice adresă IP

    // leagă socket-ul la adresa specificată
    if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) { 
        printf("Eroare la bind\n"); // mesaj de eroare
        return 1; // termină programul în caz de eroare
    }

    // pune serverul în modul de ascultare pentru conexiuni
    listen(s, 5); // ascultă până la 5 conexiuni simultane

    l = sizeof(client); // obține dimensiunea structurii client
    memset(&client, 0, sizeof(client)); // setează structura client la zero

    // bucla principală care acceptă și gestionează conexiunile
    while (1) {
        // acceptă o conexiune de la un client
        c = accept(s, (struct sockaddr *) &client, &l); 
        printf("S-a conectat un client.\n"); // mesaj de informare

        // creează un nou proces pentru a deservi clientul
        if (fork() == 0) { // dacă este procesul fiu
            deservire_client(c); // apelează funcția de deservire a clientului
            return 0; // termină procesul fiu
        }
        // procesul părinte continuă să accepte noi clienți
    }
}

```