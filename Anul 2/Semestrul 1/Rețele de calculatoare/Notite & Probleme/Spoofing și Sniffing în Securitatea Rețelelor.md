
În securitatea rețelelor, **spoofing** și **sniffing** sunt două tehnici utilizate de atacatori pentru a compromite integritatea, confidențialitatea și disponibilitatea datelor. Aceste atacuri pot duce la interceptarea, modificarea sau furtul de informații critice.

### **1. Spoofing**

**Spoofing** (înșelăciune digitală) este o tehnică prin care un atacator își falsifică identitatea pentru a părea o sursă de încredere. Acest tip de atac este folosit pentru a ocoli mecanismele de autentificare, a intercepta comunicații sau a lansa atacuri mai complexe, cum ar fi **Man-in-the-Middle (MitM)** sau **Denial-of-Service (DoS)**.

#### **1.1. Tipuri de spoofing**

1. **IP Spoofing**
    
    - Atacatorul falsifică adresa IP a unui dispozitiv legitim pentru a părea că este un utilizator autentic.
    - Folosit frecvent în atacurile **DDoS**, unde pachetele sunt trimise de la adrese false pentru a supraîncărca serverele.
    - Exemple: Atacurile **SYN Flood** sau **Smurf Attack**.
2. **ARP Spoofing (ARP Poisoning)**
    
    - Atacatorul modifică tabelele ARP dintr-o rețea locală (LAN), asociind adresa sa MAC cu adresa IP a unui dispozitiv de încredere (ex: gateway).
    - Astfel, traficul este redirecționat către atacator, permițându-i să intercepteze, modifice sau blocheze datele.
    - Utilizat adesea în atacuri **Man-in-the-Middle (MitM)**.
3. **DNS Spoofing (DNS Cache Poisoning)**
    
    - Atacatorul introduce informații false în memoria cache a unui server DNS, determinând utilizatorii să fie direcționați către site-uri frauduloase.
    - Poate duce la **furt de date bancare**, **infectare cu malware** sau **phishing**.
4. **Email Spoofing**
    
    - Atacatorul trimite emailuri cu o adresă de expeditor falsificată, făcând mesajul să pară autentic.
    - Utilizat în atacurile **phishing** pentru a convinge victimele să divulge informații sensibile.
5. **Caller ID Spoofing**
    
    - Falsificarea numărului de telefon afișat la apeluri pentru a păcăli victima să răspundă.
    - Folosit în fraude bancare sau escrocherii telefonice.

#### **1.2. Măsuri de protecție împotriva spoofing-ului**

- **Filtrare IP și ACLs (Access Control Lists)** – Blochează pachetele suspecte care provin din surse nerecunoscute.
- **Utilizarea protocoalelor de securitate** – **HTTPS, DNSSEC, SPF/DKIM/DMARC** pentru email.
- **ARP Inspection și Port Security** – Configurarea switch-urilor pentru a preveni atacurile ARP Spoofing.
- **Autentificare multifactor (MFA)** – Protejează conturile împotriva atacurilor de phishing.

---
### **2. Sniffing**

**Sniffing** este procesul de interceptare și analizare a traficului de rețea. Poate fi utilizat în scopuri legitime (depanare, monitorizare), dar și malițioase, pentru a captura informații sensibile precum parole, date bancare sau mesaje private.

#### **2.1. Tipuri de sniffing**

1. **Passive Sniffing**
    
    - Atacatorul ascultă pasiv traficul într-o rețea și colectează date fără a interacționa cu ele.
    - Funcționează în rețele **hub-based**, unde tot traficul este transmis către toate dispozitivele.
    - Exemplu: Capturarea de date cu **Wireshark**.
2. **Active Sniffing**
    
    - Atacatorul manipulează traficul pentru a intercepta date, utilizând tehnici precum **ARP Spoofing**, **MAC Flooding** sau **DNS Spoofing**.
    - Funcționează în rețele **switch-based**, unde datele sunt direcționate doar către dispozitivele destinate.
3. **Man-in-the-Middle (MitM)**
    
    - Atacatorul se interpune între două părți care comunică, interceptând, modificând sau redirecționând datele fără ca acestea să știe.
    - Poate fi realizat prin **HTTPS Stripping**, **Wi-Fi Fake AP** sau **Session Hijacking**.
4. **Packet Injection**
    
    - Atacatorul modifică sau introduce pachete în traficul rețelei pentru a manipula comunicațiile.
    - Folosit în atacuri precum **DNS Hijacking** sau **Rogue DHCP Server**.

#### **2.2. Instrumente utilizate în sniffing**

- **Legitime**:
    - **Wireshark** – Monitorizare și analiză de pachete.
    - **Tcpdump** – Captură de trafic din linia de comandă.
- **Malițioase**:
    - **Ettercap** – Atacuri MitM și ARP Spoofing.
    - **dsniff** – Capturare de parole și date sensibile.
    - **Cain & Abel** – Recuperare de parole și sniffing.

5. #### **2.3. Măsuri de protecție împotriva sniffing-ului**

- **Utilizarea criptării end-to-end** (SSL/TLS, VPN) pentru a proteja datele în tranzit.
- **Implementarea rețelelor switched** pentru a limita accesul la pachete neautorizate.
- **Utilizarea de certificate digitale** pentru a preveni atacurile MitM.
- **Monitorizarea rețelei** și utilizarea de IDS/IPS pentru detectarea activităților suspecte.
