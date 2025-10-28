
În rețelistică, cablurile sunt utilizate pentru a conecta dispozitive precum computere, switch-uri, routere și alte echipamente de rețea. Cele mai comune tipuri de cabluri sunt **cablurile Ethernet**, care pot fi **directe (straight-through)** sau **încrucișate (crossover)**.

#### **1. Cablul Direct (Straight-Through)**

🔹 **Descriere:**

- Folosit pentru conectarea **dispozitivelor diferite** între ele.
- Pinii de pe un capăt al cablului sunt identici cu cei de pe celălalt capăt.
- Conectorii RJ-45 respectă standardele **TIA/EIA 568A – 568A** sau **568B – 568B**.

🔹 **Utilizare:**  
✔ PC → Switch  
✔ PC → Router  
✔ Switch → Router  
✔ Hub → Router

🔹 **Schema de cablare:** (TIA/EIA-568B pe ambele capete)

|Pin|Culoare|Semnal|
|---|---|---|
|1|Portocaliu-alb|TX+|
|2|Portocaliu|TX-|
|3|Verde-alb|RX+|
|4|Albastru|Neutilizat|
|5|Albastru-alb|Neutilizat|
|6|Verde|RX-|
|7|Maro-alb|Neutilizat|
|8|Maro|Neutilizat|


#### **2. Cablul Încrucișat (Crossover)**

🔹 **Descriere:**

- Folosit pentru conectarea **dispozitivelor similare** între ele.
- Pinii de transmisie (TX) și recepție (RX) sunt **încrucișați** la unul dintre capetele cablului.
- Un capăt folosește **TIA/EIA-568A**, iar celălalt **TIA/EIA-568B**.

🔹 **Utilizare:**  
✔ PC → PC (direct, fără switch)  
✔ Switch → Switch (dacă nu suportă Auto-MDIX)  
✔ Hub → Hub  
✔ Router → Router

🔹 **Schema de cablare:**  
Capăt 1 (**TIA/EIA-568A**) → Capăt 2 (**TIA/EIA-568B**)

|Pin (Capăt 1)|Culoare (568A)|Pin (Capăt 2)|Culoare (568B)|
|---|---|---|---|
|1|Verde-alb|1|Portocaliu-alb|
|2|Verde|2|Portocaliu|
|3|Portocaliu-alb|3|Verde-alb|
|6|Portocaliu|6|Verde|

ℹ **Notă:** Celelalte fire nu sunt utilizate în rețele Fast Ethernet (10/100 Mbps), dar sunt necesare pentru Gigabit Ethernet.

#### **3. Cablul Ethernet (Standard, Twisted Pair – UTP, STP, FTP)**

📌 **Ethernet** este tehnologia dominantă pentru rețelele cablate. Cablurile Ethernet sunt clasificate în funcție de **categoria lor**:

- **Cat5e** – Suportă 1 Gbps (Gigabit Ethernet).
- **Cat6** – Suportă 10 Gbps pe distanțe scurte.
- **Cat7, Cat8** – Folosite pentru viteze mai mari și protecție mai bună.

📌 **Tipuri de cabluri Ethernet:**

|Tip|Protecție|Utilizare|
|---|---|---|
|**UTP (Unshielded Twisted Pair)**|Fără protecție|Comun în rețele LAN casnice și birouri|
|**STP (Shielded Twisted Pair)**|Protecție pe fiecare pereche|Reduce interferențele electromagnetice|
|**FTP (Foiled Twisted Pair)**|Ecranare generală|Protejează împotriva perturbațiilor externe|



#### **4. Auto-MDIX: Eliminarea necesității cablurilor crossover**

🔹 **Auto-MDIX (Automatic Medium-Dependent Interface Crossover)** este o tehnologie care permite dispozitivelor de rețea să detecteze și să ajusteze conexiunea automat.  
🔹 **Dispozitive moderne (switch-uri, routere, plăci de rețea)** suportă Auto-MDIX, eliminând necesitatea cablurilor crossover.

📌 **Dispozitive care suportă Auto-MDIX:**  
✔ Majoritatea switch-urilor moderne  
✔ Plăcile de rețea de pe laptopuri și PC-uri noi  
✔ Routerele moderne


#### **5. Concluzie**

✔ **Cablurile Direct (Straight-Through)** sunt utilizate pentru conectarea **dispozitivelor diferite**.  
✔ **Cablurile Încrucișate (Crossover)** sunt utilizate pentru conectarea **dispozitivelor similare**.  
✔ **Auto-MDIX elimină necesitatea cablurilor crossover** în rețelele moderne.  
✔ **Cat5e, Cat6 și Cat7** sunt cele mai utilizate cabluri Ethernet, fiecare având avantaje diferite.

### **Cablare UTP și STP – Diferențe și Utilizări**

Cablurile folosite în rețele Ethernet sunt de obicei **cabluri torsadate (Twisted Pair)**, împărțite în două mari categorii:

- **UTP (Unshielded Twisted Pair)** – fără protecție împotriva interferențelor.
- **STP (Shielded Twisted Pair)** – cu protecție suplimentară împotriva interferențelor electromagnetice.


#### **1. Cablul UTP (Unshielded Twisted Pair)**

🔹 **Ce este?**

- Un cablu torsadat **fără ecranare** suplimentară împotriva interferențelor.
- Cele mai utilizate în rețelele Ethernet, fiind **mai ieftine și mai flexibile**.

🔹 **Caracteristici:**  
✅ Cost redus și ușor de instalat.  
✅ Utilizat în majoritatea rețelelor LAN.  
✅ Poate fi afectat de interferențe electromagnetice (EMI) dacă este aproape de echipamente electrice puternice.

🔹 **Utilizare:**  
✔ Rețele casnice și de birou (Ethernet, Cat5e, Cat6, Cat6a).  
✔ Telefonie și cabluri de date.  
✔ Camere de supraveghere (dacă nu sunt lângă surse de interferențe).


#### **2. Cablul STP (Shielded Twisted Pair)**

🔹 **Ce este?**

- Similar cu UTP, dar cu **protecție împotriva interferențelor**.
- Fiecare pereche de fire poate avea un strat de **ecranare metalică** (folie sau împletitură de cupru).

🔹 **Tipuri de ecranare STP:**

|Tip|Descriere|
|---|---|
|**FTP (Foiled Twisted Pair)**|Are un singur strat de folie de aluminiu care învelește toate perechile de fire.|
|**STP (Shielded Twisted Pair)**|Fiecare pereche este protejată individual cu folie.|
|**S/FTP (Shielded Foiled Twisted Pair)**|Fiecare pereche are folie și întregul cablu are un strat suplimentar de protecție (ecranare dublă).|

🔹 **Caracteristici:**  
✅ Protecție împotriva interferențelor EMI și RF.  
✅ Utilizat în medii industriale sau în zone cu echipamente electrice puternice.  
✅ Mai scump și mai greu de instalat decât UTP.

🔹 **Utilizare:**  
✔ Rețele din fabrici, spitale, aeroporturi (unde sunt multe interferențe).  
✔ Cablare în apropierea cablurilor electrice de înaltă tensiune.  
✔ Data centers și conexiuni de mare viteză.


#### **3. Compararea UTP vs. STP**

|Caracteristică|**UTP**|**STP**|
|---|---|---|
|**Protecție împotriva interferențelor**|❌ Nu|✅ Da|
|**Flexibilitate**|✅ Ușor de instalat|❌ Mai rigid|
|**Cost**|✅ Mai ieftin|❌ Mai scump|
|**Performanță în medii cu EMI ridicat**|❌ Afectat de interferențe|✅ Funcționează bine|
|**Distanță maximă fără pierderi**|~100m|~100m (dar cu mai puține erori)|


#### **4. Concluzie**

✔ **Cablul UTP** este alegerea ideală pentru **majoritatea rețelelor LAN** datorită costului redus și instalării ușoare.  
✔ **Cablul STP** este recomandat **în medii industriale**, lângă echipamente electrice puternice, pentru a preveni interferențele.
