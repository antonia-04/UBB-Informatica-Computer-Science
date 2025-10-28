#### Servere

Un server este un program sau un dispozitiv care oferă servicii altor programe sau dispozitive, numite clienți. Serverele ascultă cererile clienților și le răspund în funcție de logica de afaceri implementată.

**Servere concurente**
- permit mai multor clienți să comunice simultan cu serverul
- esențiale pentru aplicațiile care necesită o reacție rapidă și gestionarea mai multor conexiuni în același timp.

#### Proceduri

##### TCP (Transmission Control Protocol)
- Protocol de comunicație orientat pe conexiune care asigură livrarea fiabilă a datelor între client și server.
- Caracteristici
	- asigură livrarea ordonată a pachetelor de date.
	- realizează controlul fluxului și corectarea erorilor.
	- folosit pentru aplicații care necesită fiabilitate, cum ar fi browser-ele web, e-mailurile.
##### UDP (User Datagram Protocol)
- Protocol de comunicație neorientat pe conexiune care permite trimiterea rapidă de date fără a asigura livrarea fiabilă.
- Caracteristici
	- nu garantează livrarea sau ordinea pachetelor
	- folosit pentru aplicații care necesită viteza, cum ar fi streaming-ul audio/video sau jocurile online