
**Agregarea rețelelor** este procesul de combinare a mai multor rețele IP mai mici într-o rețea mai mare, reducând astfel numărul de rute dintr-o tabelă de rutare. Aceasta este folosită pentru a îmbunătăți eficiența rutării și a reduce dimensiunea tabelelor de rutare în rețelele mari.

### **1. Ce este Supernetting (Route Aggregation)?**

Supernetting implică **gruparea mai multor rețele IP contigue într-o singură intrare de rutare**, reducând numărul de rute anunțate de un router.

🔹 **Exemplu simplu:**  
Avem patru rețele de clasă C:

- **192.168.1.0/24**
- **192.168.2.0/24**
- **192.168.3.0/24**
- **192.168.4.0/24**

În loc să avem 4 rute separate, putem face agregare într-o singură rută:

- **192.168.0.0/22 (mască 255.255.252.0)**

Acest lucru reduce complexitatea rețelei și optimizează utilizarea adreselor IP.

### **2. Avantajele agregării de rețele**

✅ **Reducerea dimensiunii tabelelor de rutare** – Routerele gestionează mai puține rute individuale.  
✅ **Eficiență crescută a rutării** – Mai puține actualizări de rută și un consum mai mic de resurse.  
✅ **Reducerea consumului de memorie și procesare** pe routere.  
✅ **Îmbunătățirea convergenței** în protocoale de rutare (OSPF, BGP, EIGRP).


### **3. Cum se face agregarea de rețele?**

#### **Pas 1: Identificarea rețelelor contigue**

- Rețelele trebuie să fie **adiacente** (ex: 192.168.1.0/24 și 192.168.2.0/24).
- Trebuie să aibă o **mască comună mai mare** pentru a fi agregate.

#### **Pas 2: Alegerea unei măști de rețea mai mari**

Folosim **CIDR (Classless Inter-Domain Routing)** pentru a determina cea mai mică mască comună care acoperă toate rețelele.

🔹 **Exemplu:**  
Avem rețelele **10.1.0.0/24** și **10.1.1.0/24**.

Le putem agrega într-o singură rețea **10.1.0.0/23** (mască **255.255.254.0**).

#### **Pas 3: Anunțarea agregării**

- În **OSPF** – folosim **summarization** la nivel de Area Border Router (ABR).
- În **BGP** – utilizăm agregare de rute pentru a optimiza anunțurile către alte rețele.


### **4. Supernetting vs Subnetting**

|Caracteristică|Subnetting|Supernetting|
|---|---|---|
|Scop|Împărțirea unei rețele mari în subrețele mai mici|Combinarea mai multor rețele mai mici într-una mai mare|
|Crește sau reduce numărul de rețele?|Crește numărul de rețele|Reduce numărul de rețele|
|Masca de subrețea|Crește (ex: /24 → /26)|Scade (ex: /24 → /22)|
|Utilizare|Rețele LAN, VLAN-uri|Internet, rutare BGP|

## **5. Exemple practice**

🔹 **Exemplu cu 4 rețele /24**  
Rețele:

- 172.16.0.0/24
- 172.16.1.0/24
- 172.16.2.0/24
- 172.16.3.0/24

Le agregăm într-o singură rețea:

- **172.16.0.0/22** (mască **255.255.252.0**)

🔹 **Exemplu cu BGP (Border Gateway Protocol)**  
Dacă un ISP gestionează multiple rețele, în loc să anunțe:

- **203.0.113.0/24**
- **203.0.114.0/24**

Poate agrega într-un singur prefix:

- **203.0.112.0/22**
