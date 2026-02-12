### 1. **Care atribute din listă sunt acceptate de către un anumit tag?**

Atributele din listă sunt acceptate de anumite tag-uri HTML. Le voi grupa pe categorii în funcție de tipul elementelor HTML la care se aplică.

#### **1.1. Atribute pentru elemente de tip link (`<a>`)**

- **`href`** – specifică adresa URL către care duce link-ul.
    - Ex.: `<a href="https://example.com">Click aici</a>`
- **`name`** _(depreciat în HTML5)_ – era folosit pentru a defini o ancoră internă într-o pagină. Se folosește acum `id`.
    - Ex.: `<a name="secțiune1"></a>`
- **`target`** – definește unde să se deschidă link-ul.
    - Valori posibile:
        - `_self` (implicit, deschide în aceeași fereastră)
        - `_blank` (deschide într-o fereastră nouă)
        - `_parent`, `_top`

#### **1.2. Atribute pentru imagini (`<img>`)**

- **`src`** – definește calea imaginii.
    - Ex.: `<img src="imagine.jpg" alt="O descriere">`
- **`alt`** – text alternativ afișat dacă imaginea nu se încarcă.
- **`height` / `width`** – definește dimensiunea imaginii în pixeli sau procente.
- **`title`** – text afișat la hover peste imagine.


#### **1.3. Atribute pentru elemente de tabel (`<table>`, `<tr>`, `<td>`, `<th>`)**

- **`border`** _(depreciat în HTML5)_ – definește grosimea conturului tabelului. CSS este recomandat în locul acestuia.
    - Ex.: `<table border="1">`
- **`colspan`** (pentru `<td>`, `<th>`) – determină câte coloane să ocupe celula.
- **`align`** _(depreciat în HTML5)_ – aliniază textul în interiorul unei celule (`left`, `center`, `right`).
- **`valign`** _(depreciat în HTML5)_ – aliniază conținutul pe verticală (`top`, `middle`, `bottom`).
- **`width` / `height`** _(depreciate în HTML5)_ – definesc dimensiunile tabelului sau celulelor.
- **`bgcolor`** _(depreciat în HTML5)_ – stabilește culoarea de fundal a unei celule.


#### **1.4. Atribute pentru elemente de formular (`<form>`, `<input>`, `<textarea>`)**

- **Atribute pentru `<form>`**
    
    - `action` – definește URL-ul unde sunt trimise datele formularului.
    - `method` – definește metoda HTTP (`GET` sau `POST`).
- **Atribute pentru `<input>`**
    
    - `type` – definește tipul câmpului de input (`text`, `password`, `checkbox`, `radio`, `submit`, `number` etc.).
    - `maxlength` – definește numărul maxim de caractere permise.
    - `readonly` – face câmpul doar pentru citire (nu permite editare).
    - `size` – definește lățimea câmpului de input în caractere.
    - `value` – definește valoarea implicită a câmpului.
    - `checked` (pentru `checkbox` și `radio`) – marchează opțiunea ca selectată implicit.
    - `disabled` – dezactivează câmpul, împiedicând utilizatorul să interacționeze cu el.
    - `step` _(doar pentru `<input type="number">` și `<input type="range">`)_ – definește incrementul numeric permis la modificare.
        - Ex.: `<input type="number" step="0.5">` permite valori precum `0.5, 1, 1.5, 2...`.
- **Atribute pentru `<textarea>`**
    
    - `cols` – definește numărul de coloane vizibile (lățimea).
    - `rows` – definește numărul de rânduri vizibile (înălțimea).
    - `maxlength` – definește numărul maxim de caractere permise.


### 2. **Ce valori specifice poate lua un anumit atribut?**

Atributele HTML pot avea anumite valori predefinite sau opțiuni care depind de tipul atributului. Aceste valori definesc comportamentul sau stilul unui element HTML. Vom explora câteva dintre cele mai comune atribute și valorile lor posibile:


#### **2.1. Atribute cu valori predefinite**

##### **`target` (pentru `<a>`, `<form>`)**

- **Valori posibile:**
    - **`_self`** – deschide link-ul sau formularul în aceeași fereastră/tab (implicit).
    - **`_blank`** – deschide link-ul sau formularul într-o fereastră/tab nouă.
    - **`_parent`** – deschide în fereastra părinte a documentului curent.
    - **`_top`** – deschide în fereastra întreagă, ignorând orice frameset.

##### **`type` (pentru `<input>`)**

- **Valori posibile:**
    - **`text`** – câmp pentru text.
    - **`password`** – câmp pentru parolă, caracterele sunt ascunse.
    - **`email`** – câmp pentru adresă de email (verifică sintaxa email-ului).
    - **`number`** – câmp pentru numere.
    - **`radio`** – buton radio (permite selectarea unei singure opțiuni dintr-un grup).
    - **`checkbox`** – casetă de selectare (permite selecția mai multor opțiuni).
    - **`submit`** – buton pentru trimiterea formularului.
    - **`reset`** – buton pentru resetarea formularului.
    - **`file`** – câmp pentru a selecta un fișier.
    - **`date`** – câmp pentru selectarea unei date (cu selector de dată).
    - **`range`** – câmp pentru a selecta un număr într-un interval dat.

##### **`method` (pentru `<form>`)**

- **Valori posibile:**
    - **`GET`** – trimite datele prin URL (vizibile în bara de adrese).
    - **`POST`** – trimite datele în corpul cererii HTTP (nu vizibile în bara de adrese, mai sigur pentru date sensibile).

##### **`input type="number"` – atributul `step`**

- **Valori posibile:**
    - **`step="0.5"`** – acceptă valori cu zecimale, de exemplu `0.5, 1, 1.5...`.
    - **`step="1"`** – acceptă doar valori întregi.


#### **2.2. Atribute cu valori definite de utilizator**

##### **`class` (pentru orice element HTML)**

- **Valori posibile:**
    - Orice valoare care poate reprezenta o clasă CSS, de exemplu: `"container"`, `"btn-primary"`, `"highlighted"`.

##### **`id` (pentru orice element HTML)**

- **Valori posibile:**
    - Un identificator unic pentru elementul respectiv. De exemplu: `"header"`, `"footer"`, `"section-1"`. Este important să fie unic în document.

##### **`style` (pentru orice element HTML)**

- **Valori posibile:**
    - Oricare stil CSS inline aplicat unui element. Exemplu: `"color: red; font-size: 16px;"`.

##### **`name` (pentru `<input>`, `<textarea>`, `<form>`, etc.)**

- **Valori posibile:**
    - Orice nume care poate identifica un element în formular. De exemplu: `"username"`, `"password"`, `"email"`.


#### **2.3. Atribute pentru imagini (`<img>`)**

##### **`src`**

- **Valori posibile:**
    - Calea fișierului sursă al imaginii. De exemplu:
        - **Local**: `"imagine.jpg"`
        - **URL**: `"https://example.com/imagine.jpg"`

##### **`alt`**

- **Valori posibile:**
    - Text descriptiv pentru imagine, afișat în cazul în care imaginea nu poate fi încărcată. De exemplu: `"Imaginea unui peisaj montan"`.

##### **`title`**

- **Valori posibile:**
    - Text afișat ca tooltip atunci când utilizatorul hover peste imagine. De exemplu: `"Click pentru a vedea mai multe imagini"`.


#### **2.4. Atribute pentru tabele (`<table>`, `<td>`, `<th>`)**

##### **`align` (pentru `<table>`, `<td>`, `<th>`)** _(depreciat în HTML5)_

- **Valori posibile:**
    - **`left`** – alinierea la stânga.
    - **`center`** – alinierea la centru.
    - **`right`** – alinierea la dreapta.

##### **`valign` (pentru `<td>`, `<th>`)** _(depreciat în HTML5)_

- **Valori posibile:**
    - **`top`** – alinierea la partea superioară a celulei.
    - **`middle`** – alinierea la mijlocul vertical.
    - **`bottom`** – alinierea la partea inferioară a celulei.

### 3. **Care dintre tag-urile / atributele de mai sus sunt deprecated în HTML5?**

În HTML5, unele tag-uri și atribute au fost marcate ca **deprecated** sau **obsolete**, adică nu mai sunt recomandate pentru utilizare și, în unele cazuri, nu mai sunt acceptate de majoritatea browserelor sau ar putea fi eliminate în versiunile viitoare ale standardului. Acestea au fost înlocuite cu metode mai moderne sau mai semantice pentru a îmbunătăți accesibilitatea și standardele web.

Iată câteva dintre tag-urile și atributele **deprecated** în HTML5:


#### **3.1. Tag-uri Deprecated în HTML5**

##### **`<font>`**

- Înlocuit de stiluri CSS pentru a controla fonturile. De exemplu, folosind `font-family`, `font-size`, și `color` în CSS.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <font color="red" size="4">Text roșu</font>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <span style="color: red; font-size: 16px;">Text roșu</span>
        ```
        

##### **`<center>`**

- Înlocuit de `text-align: center` în CSS. De asemenea, există metode CSS mai eficiente pentru alinierea centrului.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <center>Text centrat</center>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <div style="text-align: center;">Text centrat</div>
        ```
        

##### **`<u>`**

- Folosit pentru a sublinia textul, dar în HTML5 este considerat mai bine să folosești CSS pentru a adăuga subliniere, deoarece `<u>` poate fi confundat cu un semn de legătură (link).
    - **Exemplu vechi (deprecated):**
        
        ```html
        <u>Text subliniat</u>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <span style="text-decoration: underline;">Text subliniat</span>
        ```
        

##### **`<strike>`**

- Folosit pentru a tăia textul (a adăuga o linie peste), dar în HTML5 este considerat că nu reflectă semnificația dorită. În loc să folosești `<strike>`, se recomandă `<del>` pentru text șters sau `<s>` pentru text care nu este corect.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <strike>Text tăiat</strike>
        ```
        
    - **Exemplu modern (semantica):**
        
        ```html
        <del>Text șters</del>
        ```
        


#### **3.2. Atribute Deprecated în HTML5**

##### **`align`** (pentru multe elemente, cum ar fi `<table>`, `<tr>`, `<div>`, etc.)

- Înlocuit de stiluri CSS, cum ar fi `text-align` sau `vertical-align`.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <div align="center">Text centrat</div>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <div style="text-align: center;">Text centrat</div>
        ```
        

##### **`bgcolor`** (pentru `<body>`, `<table>`, `<td>`, etc.)

- Înlocuit de `background-color` în CSS.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <table bgcolor="yellow">...</table>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <table style="background-color: yellow;">...</table>
        ```
        

##### **`border`** (pentru `<table>`, `<img>`, etc.)

- Înlocuit de `border` în CSS.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <table border="1">...</table>
        ```
        
    - **Exemplu modern (CSS):**
        
        ```html
        <table style="border: 1px solid black;">...</table>
        ```
        

##### **`frame`** (pentru `<table>`)

- Înlocuit de CSS pentru controlul aspectului marginilor.
    - **Exemplu vechi (deprecated):**
        
        ```html
        <table frame="box">...</table>
        ```
        

##### **`method="get"` sau `method="post"` în `<form>` (deprecated în anumite contexte)**

- Este încă acceptat, dar poate fi considerat inadecvat în anumite contexte de aplicații mai complexe, fiind înlocuit cu metode de gestionare a formularului folosind JavaScript.


### **Recapitulare**

Aceste tag-uri și atribute **deprecated** au fost eliminate din standardele HTML5 deoarece s-au dovedit a fi ineficiente sau au fost înlocuite cu metode mai semantice și accesibile, adesea prin CSS sau JavaScript. Este recomandat să înlocuiești aceste elemente cu soluții moderne pentru a respecta standardele HTML5 și a asigura compatibilitatea pe termen lung.


### 4. **Care dintre tag-urile / atributele de mai sus nu sunt suportate în HTML 4.01 Transitional?**

HTML 4.01 Transitional este o versiune mai veche a standardului HTML, care permite utilizarea unor tag-uri și atribute mai vechi pentru a asigura compatibilitatea cu browserele mai vechi și pentru a face tranziția la HTML5 mai ușoară. Totuși, există unele tag-uri și atribute care nu sunt acceptate sau nu sunt recomandate în **HTML 4.01 Transitional**.

Iată o listă cu tag-urile și atributele **neacceptate** sau **nele-compatibile** în HTML 4.01 Transitional:


#### **4.1. Tag-uri care nu sunt suportate în HTML 4.01 Transitional**

##### **`<main>`**

- HTML 4.01 nu include conceptul de elemente semantice ca în HTML5, iar tag-ul `<main>` nu există în HTML 4.01.
    - **HTML5:**
        
        ```html
        <main>
          <h1>Conținut principal</h1>
          <p>...</p>
        </main>
        ```
        
    - **HTML 4.01:** HTML 4.01 nu are un tag semnificativ pentru „main”. Se poate folosi un `<div>` cu o clasă specifică, dar nu este semnificativ.
        
        ```html
        <div class="main">
          <h1>Conținut principal</h1>
          <p>...</p>
        </div>
        ```
        

##### **`<article>`, `<section>`, `<nav>`, `<footer>` și alte tag-uri semantice**

- Toate aceste tag-uri semantice au fost introduse în HTML5 și nu există în HTML 4.01.
    - **HTML5:**
        
        ```html
        <article>
          <h2>Titlu articol</h2>
          <p>Conținut...</p>
        </article>
        ```
        
    - **HTML 4.01:** Nu există tag-uri semantice directe pentru `<article>` sau `<section>`. Ar trebui folosit un `<div>`:
        
        ```html
        <div class="article">
          <h2>Titlu articol</h2>
          <p>Conținut...</p>
        </div>
        ```
        

##### **`<figure>` și `<figcaption>`**

- În HTML4, pentru imagini și descrieri, se foloseau tag-uri ca `<img>` și `<caption>`, dar `<figure>` și `<figcaption>` nu există în HTML 4.01.
    - **HTML5:**
        
        ```html
        <figure>
          <img src="imagine.jpg" alt="Descriere imagine">
          <figcaption>Legenda imaginii</figcaption>
        </figure>
        ```
        
    - **HTML 4.01:** Utilizați un `<div>` sau un `<figcaption>` separat pentru imagini:
        
        ```html
        <div class="image">
          <img src="imagine.jpg" alt="Descriere imagine">
          <div class="caption">Legenda imaginii</div>
        </div>
        ```
        

##### **`<mark>`, `<progress>`, `<output>`, `<meter>`**

- Aceste tag-uri au fost introduse în HTML5 și nu sunt suportate în HTML 4.01.
    - **HTML5:**
        
        ```html
        <mark>Text marcat</mark>
        <progress value="70" max="100">70%</progress>
        ```
        
    - **HTML 4.01:** Aceste tag-uri nu sunt disponibile. De exemplu, pentru evidențierea textului, poți folosi `<b>` sau `<span>` cu stil CSS:
        
        ```html
        <b>Text marcat</b>
        ```
        


#### **4.2. Atribute care nu sunt suportate în HTML 4.01 Transitional**

##### **`required`, `placeholder`, `autofocus` (pentru formulare)**

- Aceste atribute sunt utilizate în HTML5 pentru a îmbunătăți interacțiunea cu formularele și a oferi validare nativă a datelor.
    - **HTML5:**
        
        ```html
        <input type="text" required placeholder="Introduceti numele" autofocus>
        ```
        
    - **HTML 4.01:** Aceste atribute nu există. În HTML 4.01, validarea era realizată prin scripturi externe (JavaScript), iar câmpurile nu aveau funcționalitățile native de validare.
        
        ```html
        <input type="text">
        ```
        

##### **`type="email"`, `type="tel"`, `type="date"` (pentru formulare)**

- HTML5 a introdus tipuri de input mai specifice, dar HTML 4.01 acceptă doar tipurile generice de `text`, `password`, `submit` etc.
    - **HTML5:**
        
        ```html
        <input type="email" placeholder="email@exemplu.com">
        <input type="date">
        ```
        
    - **HTML 4.01:** HTML 4.01 nu acceptă tipuri de input precum `email` sau `date`. Acestea vor fi tratate ca `text`:
        
        ```html
        <input type="text" placeholder="email@exemplu.com">
        ```
        

##### **`charset` (în tag-ul `<meta>`)**

- În HTML4, se folosea un alt mod de a seta encoding-ul caracterelor. Atributul `charset` în tag-ul `<meta>` este specific HTML5.
    - **HTML5:**
        
        ```html
        <meta charset="UTF-8">
        ```
        
    - **HTML 4.01:** În HTML 4.01 se folosește `http-equiv="Content-Type"`:
        
        ```html
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        ```
        


### **Recapitulare**

HTML 4.01 Transitional acceptă multe tag-uri și atribute vechi, dar nu include multe dintre caracteristicile semantice și funcționalitățile moderne introduse în HTML5. Dacă vrei să creezi un site web compatibil cu standardele moderne, este recomandat să utilizezi HTML5, care oferă o mai bună semantica, accesibilitate și suport pentru formulare, media și interacțiune.

Dacă ai alte întrebări sau vrei să explorezi un alt punct, nu ezita să mă întrebi! 