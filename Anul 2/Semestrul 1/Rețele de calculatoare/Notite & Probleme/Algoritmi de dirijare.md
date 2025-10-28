

### **1. Algoritmi de tip Vectori de Distanță (Distance Vector - DV)**

Acești algoritmi funcționează pe principiul că fiecare router menține o **tabelă de rutare** care conține:

- Destinația (alte routere din rețea).
- Distanța către fiecare destinație (exprimată în număr de hop-uri sau altă metrică).
- Cel mai bun **next-hop** (router vecin prin care se ajunge la destinație).

#### **Cum funcționează?**

1. **Inițializare:** Fiecare router își cunoaște doar vecinii direcți.
2. **Actualizare periodică:** Routerele trimit tabelele lor de rutare către vecini la intervale regulate.
3. **Regula Bellman-Ford:** Dacă un router primește o informație mai bună (o distanță mai mică) despre o destinație de la un vecin, își actualizează tabela.
4. **Propagare lentă a schimbărilor:** Dacă apare o modificare în rețea (de exemplu, cade un link), aceasta trebuie propagată pas cu pas prin toate routerele.

#### **Avantaje și Dezavantaje:**

✅ **Avantaje:**

- Ușor de implementat și de configurat.
- Consum redus de resurse.

❌ **Dezavantaje:**

- **Convergență lentă** (durează până când toate routerele învață noua configurație).
- **Problema buclelor** – dacă un link cade, routerele pot intra într-o buclă în care trimit pachetele înainte și înapoi (exemplu: „contorizare la infinit”).
- **Limitări în rețele mari** – majoritatea implementărilor (ex. RIP) nu suportă mai mult de 15 hop-uri.

📌 **Exemplu de protocol bazat pe Distance Vector:**

- **RIP (Routing Information Protocol)** – folosește numărul de hop-uri ca metrică și trimite actualizări la fiecare 30 de secunde.


### **2. Algoritmi de tip Starea Legăturilor (Link State - LS)**

Acești algoritmi adoptă o abordare diferită: în loc să păstreze doar informații despre vecini, fiecare router construiește o **hartă completă a rețelei** și calculează cea mai bună rută către fiecare destinație.

#### **Cum funcționează?**

1. **Descoperirea vecinilor:** Routerele trimit mesaje speciale pentru a detecta ce alte routere sunt conectate direct.
2. **Schimb de informații:** Fiecare router trimite un mesaj numit **LSA (Link State Advertisement)**, care conține toate informațiile despre conexiunile sale.
3. **Construirea topologiei:** Toate routerele colectează aceste mesaje și își construiesc propria hartă completă a rețelei.
4. **Algoritmul Dijkstra:** Routerele folosesc **Dijkstra (Shortest Path First - SPF)** pentru a calcula cea mai scurtă cale către fiecare destinație.

#### **Avantaje și Dezavantaje:**

✅ **Avantaje:**

- **Convergență rapidă** – schimbările din rețea sunt detectate și propagate rapid.
- **Fără bucle** – deoarece fiecare router are o imagine completă a rețelei, deciziile sunt mai precise.
- **Scalabilitate mai bună** în comparație cu Distance Vector.

❌ **Dezavantaje:**

- **Mai multă memorie și procesare necesare** – fiecare router trebuie să stocheze și să analizeze întreaga rețea.
- **Complexitate mai mare** în implementare și administrare.

📌 **Exemplu de protocol bazat pe Link State:**

- **OSPF (Open Shortest Path First)** – folosește costul link-urilor ca metrică și actualizează rutele doar când apare o schimbare.


### **Comparație rapidă**

|Caracteristică|Distance Vector (DV)|Link State (LS)|
|---|---|---|
|**Cum funcționează**|Routerele cunosc doar vecinii și propagă informația pas cu pas|Routerele construiesc o hartă completă a rețelei|
|**Algoritm**|Bellman-Ford|Dijkstra (SPF)|
|**Exemplu de protocol**|RIP|OSPF|
|**Viteza de convergență**|Lentă|Rapidă|
|**Scalabilitate**|Limitată|Bună|
|**Consum de resurse**|Redus|Mai mare|
|**Probleme**|Posibile bucle|Mai complex, consumă mai multe resurse|


### **Pe scurt:**

- **DV (Distance Vector)** → Routerele cunosc doar vecinii și schimbă informații periodic. Bun pentru rețele mici.
- **LS (Link State)** → Routerele știu toată rețeaua și calculează rutele optim. Bun pentru rețele mari.
