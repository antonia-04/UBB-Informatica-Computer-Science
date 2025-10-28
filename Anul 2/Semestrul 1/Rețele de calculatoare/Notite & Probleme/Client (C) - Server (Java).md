Client

```C
#include <sys/types.h>          
#include <sys/socket.h>        
#include <stdio.h>              
#include <netinet/in.h>         // include pentru structurile necesare în rețea
#include <netinet/ip.h>         // include pentru protocoalele IP
#include <string.h>             // include pentru funcțiile de manipulare a string-urilor

int main() {
    int c;        // variabilă pentru identificarea socket-ului client
    // structură pentru a stoca informațiile despre server
    struct sockaddr_in server; 
    char buffer[100];          // buffer pentru a stoca mesajul trimis

    // crearea socket-ului client
    c = socket(AF_INET, SOCK_STREAM, 0);
    
    if (c < 0) {  // verifică dacă s-a creat socket-ul cu succes
        printf("Eroare la crearea socketului client\n");
        return 1; 
    }

    // inițializarea structurii server
    // ștergerea structurii pentru a evita datele vechi
    memset(&server, 0, sizeof(server)); 
    // setarea portului serverului (în format de rețea)
    server.sin_port = htons(1234);     
    // specificarea familiei de adrese (IPv4)
    server.sin_family = AF_INET;       
    // setarea adresei IP a serverului  
    server.sin_addr.s_addr = inet_addr("127.0.0.1"); 

    // conectarea la server
    if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;  // în cazul unei erori la conectare, iese din program
    }

    // cererea de introducere a unui string de la utilizator
    printf("Dati un string: ");  
    fgets(buffer, 100, stdin); // citirea stringului introdus de utilizator
    send(c, buffer, strlen(buffer), 0); // trimiterea stringului către server

    close(c); // închiderea socket-ului client
}
```

Server

```Java
import java.net.*; // importă clasele necesare pentru socket-uri
import java.io.*;  // importă clasele necesare pentru input/output

public class Server {
 
    public static void main(String args[]) throws Exception {
	    // crearea socket-ului server pe portul 1234
        ServerSocket s = new ServerSocket(1234); 
        // buffer pentru a stoca mesajele primite
        byte b[] = new byte[100]; 
		// bucla infinită pentru a accepta conexiuni
        while (true) { 
	        // acceptarea unei conexiuni de la un client
            Socket c = s.accept(); 
             // mesaj de confirmare pentru conexiune
            System.out.println("Client connected!");
            // citirea datelor trimise de client în buffer
            c.getInputStream().read(b); 
            // afișarea stringului primit convertit din byte în string
            System.out.println(new String(b));

            c.close(); // închiderea socket-ului client
        }  
    }
}

```