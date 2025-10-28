
#### **Ce este SNAT?**

**SNAT (Source Network Address Translation)** este un mecanism de **modificare a adresei IP sursă** a unui pachet care pleacă dintr-o rețea. Este utilizat în principal pentru a permite dispozitivelor cu adrese IP private să acceseze internetul folosind o adresă IP publică.


#### **Cum funcționează SNAT?**

1. **Un dispozitiv dintr-o rețea locală trimite un pachet către o destinație externă** (ex. internet).
2. **Routerul/NAT Gateway-ul înlocuiește adresa IP sursă a pachetului** cu o altă adresă IP (de obicei publică).
3. **Pachetul modificat este trimis către destinație**, iar serverul răspunde către noua adresă IP sursă.
4. **Routerul face maparea inversă** și redirecționează răspunsul către dispozitivul inițial.


#### **Ce tipuri de adrese poate translata SNAT?**

SNAT poate translata adrese **false (private) și reale (publice)**, în diverse combinații:

|**Tip de translație**|**Explicație**|**Exemplu**|
|---|---|---|
|✅ **Privat → Public** (fals → real)|Cel mai folosit caz: dispozitive cu IP privat accesează internetul folosind un IP public.|`192.168.1.10 → 203.0.113.5`|
|✅ **Public → Public** (real → real)|Se folosește în load balancing sau în cloud, unde un IP public este înlocuit cu alt IP public.|`198.51.100.10 → 203.0.113.20`|
|✅ **Privat → Privat** (fals → fals)|Rar folosit, dar poate apărea în rețele interne mari, unde un grup de adrese private este translatat în alt grup de adrese private.|`192.168.1.10 → 10.0.0.5`|
|❌ **Public → Privat** (real → fals)|**SNAT nu poate face acest lucru**, dar **DNAT (Destination NAT)** poate redirecționa traficul de la o adresă publică către una privată (ex. Port Forwarding).|`203.0.113.10 ❌→ 192.168.1.100`|


#### **Dacă avem nevoie de Public → Privat?**

Dacă vrem să modificăm **destinația** unui pachet astfel încât să ajungă la un IP privat, se folosește **DNAT (Destination NAT)**, nu SNAT.

**Exemplu DNAT (Public → Privat):**  
🔹 Un server public (`203.0.113.10`) primește o cerere pe portul 80.  
🔹 Routerul schimbă adresa **destinație** către un server privat (`192.168.1.100`).  
🔹 Acesta răspunde înapoi, iar routerul face maparea inversă pentru ca pachetul să pară că vine de la IP-ul public.

💡 **Acest proces este folosit în Port Forwarding și NAT Hairpinning.**


#### **Unde este folosit SNAT?**

✅ **Acces la internet pentru dispozitive cu IP privat** (cel mai frecvent caz)  
✅ **Load Balancing și Failover în cloud** (pentru distribuirea traficului)  
✅ **Securitate și filtrare** (ascunderea adreselor reale ale clienților)  
✅ **Rețele mari interne** (unde un grup de IP-uri private este convertit în alt grup)



##### **Exemplu de SNAT pe Linux (iptables)**

```bash
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 203.0.113.5
```

👉 Această regulă modifică **IP-ul sursă** al tuturor pachetelor care ies prin interfața **eth0**, înlocuindu-l cu **203.0.113.5**.


##### **Concluzie:**

✅ **SNAT:** Poate face **fals → real**, **real → real**, **fals → fals**.  
❌ **SNAT NU poate face real → fals**, dar **DNAT poate redirecționa pachete de la un IP real spre un IP fals**.

Dacă ai nevoie de mai multe explicații sau exemple, întreabă! 🚀