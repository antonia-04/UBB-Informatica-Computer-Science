
### **CSS Selectors & Combinators**

#### **1️⃣ Selectori de bază**

- **Selector de tag (element)** – Selectează toate elementele de un anumit tip.
    
    ```css
    p {
        color: blue;
    }
    ```
    
    _Afectează toate elementele `<p>` din pagină._
    
- **Selector de clasă (`.`)** – Selectează toate elementele care au o anumită clasă.
    
    ```css
    .table {
        border: 1px solid black;
    }
    ```
    
    _Poți aplica mai multe clase unui element:_
    
    ```html
    <div class="table bordered"></div>
    ```
    
- **Selector de ID (`#`)** – Selectează un singur element cu un ID specific.
    
    ```css
    #main-header {
        background-color: gray;
    }
    ```
    
    ⚠️ **ID-urile trebuie să fie unice în pagină!**
    
- **Selector universal (`*`)** – Se aplică tuturor elementelor din pagină.
    
    ```css
    * {
        margin: 0;
        padding: 0;
    }
    ```
    

---

#### **2️⃣ Combinatori CSS**

Combinatorii definesc relațiile dintre selectori.

|Combinator|Descriere|Exemplu|
|---|---|---|
|**Descendent ( )**|Selectează elementele din interiorul altuia|`div p { color: red; }` → Toate `<p>` din `<div>`|
|**Copil direct (`>`)**|Selectează doar copiii direcți ai unui element|`div > p { color: red; }`|
|**Frate general (`~`)**|Selectează toate elementele de același nivel care vin după un alt element|`h2 ~ p { color: green; }`|
|**Frate imediat (`+`)**|Selectează doar primul element de același nivel care vine imediat după altul|`h2 + p { font-weight: bold; }`|

---

### 🛠 **Exemple practice**

#### **Descendent ( )**

```css
div p {
    color: red;
}
```

```html
<div>
    <p>Acest text este roșu.</p>
</div>
```

#### **Copil direct (`>`)**

```css
div > p {
    color: blue;
}
```

```html
<div>
    <p>Acest text va fi albastru.</p>
    <section>
        <p>Acest text NU va fi afectat.</p>
    </section>
</div>
```

#### **Frate imediat (`+`)**

```css
h2 + p {
    color: green;
}
```

```html
<h2>Titlu</h2>
<p>Acest paragraf devine verde.</p>
<p>Acest paragraf NU este afectat.</p>
```

#### **Frate general (`~`)**

```css
h2 ~ p {
    font-style: italic;
}
```

```html
<h2>Titlu</h2>
<p>Toate paragrafele după `h2` vor fi italice.</p>
<p>Inclusiv acesta!</p>
```

---

### 📌 **Rezumat**

✅ **Tag selector (`p`)** – Selectează toate elementele de un tip.  
✅ **Clasă (`.table`)** – Poate fi aplicată mai multor elemente.  
✅ **ID (`#id`)** – Trebuie să fie unic.  
✅ **Universal (`*`)** – Aplică stiluri tuturor elementelor.  
✅ **Combinatori** – Definesc relațiile între elemente.

👉 **Folosește combinatorii pentru un CSS mai eficient și organizat!**



## **🎨 Pseudo-elemente și selectori de atribute în CSS**

---

### **🔹 1. Pseudo-elemente (`::before`, `::after`, etc.)**

Pseudo-elementele permit stilizarea anumitor părți ale unui element, fără a adăuga elemente suplimentare în HTML.

📌 **Sintaxă:**

```css
selector::pseudo-element {
    proprietate: valoare;
}
```

#### **1️⃣ `::before` și `::after`**

Acestea adaugă conținut înainte sau după un element. Necesită `content:` în CSS.

```css
button::before {
    content: "🔥";
    margin-right: 5px;
}

button::after {
    content: " ✅";
    color: green;
}
```

```html
<button>Click me</button>
```


---

#### **2️⃣ `::first-letter` și `::first-line`**

- `::first-letter` – Stilizează prima literă a unui element.
- `::first-line` – Stilizează prima linie a unui element (depinde de dimensiunea containerului).

```css
p::first-letter {
    font-size: 2em;
    color: red;
}

p::first-line {
    font-weight: bold;
}
```

```html
<p>Acesta este un paragraf lung. Prima literă va fi mai mare, iar prima linie va fi bold.</p>
```

---

#### **3️⃣ `::selection`**

Stilizează textul selectat de utilizator.

```css
::selection {
    background: yellow;
    color: black;
}
```

👉 Când utilizatorul selectează textul, acesta va avea fundal galben și text negru.

---

### **🔹 2. Selectori pentru atribute (`[atribut]`)**

Acești selectori permit stilizarea elementelor în funcție de atributele lor.

📌 **Exemple:**

|Selector|Descriere|
|---|---|
|`input[type="text"]`|Selectează toate `<input>` de tip text.|
|`a[target="_blank"]`|Selectează toate linkurile care se deschid într-o fereastră nouă.|
|`[disabled]`|Selectează toate elementele cu atributul `disabled`.|
|`input[placeholder]`|Selectează `<input>` care au un atribut `placeholder`.|

---

### **🛠 Exemple practice:**

#### **1️⃣ Stilizare pentru `<input>` de tip text**

```css
input[type="text"] {
    border: 2px solid blue;
    padding: 5px;
}
```

```html
<input type="text" placeholder="Introduceți textul aici">
```

---

#### **2️⃣ Stilizare pentru linkuri externe (`target="_blank"`)**

```css
a[target="_blank"] {
    color: red;
    text-decoration: underline;
}
```

```html
<a href="https://example.com" target="_blank">Link extern</a>
```

---

#### **3️⃣ Stilizare pentru elementele dezactivate (`[disabled]`)**

```css
button[disabled] {
    background: gray;
    color: white;
    cursor: not-allowed;
}
```

```html
<button disabled>Nu poți da click</button>
```

---

#### **4️⃣ Stilizare pentru `placeholder` într-un `<input>`**

```css
input::placeholder {
    color: gray;
    font-style: italic;
}
```

```html
<input type="text" placeholder="Scrie aici...">
```

---

### **📌 Rezumat**

✅ **Pseudo-elemente:** `::before`, `::after`, `::first-letter`, `::first-line`, `::selection`  
✅ **Selectori pentru atribute:** `[type="text"]`, `[disabled]`, `[placeholder]`, `[target="_blank"]`  
✅ **Combinația lor oferă un control mai avansat asupra stilizării!** 🎨🔥


## **🔢 `calc()` în CSS**

Funcția `calc()` este folosită pentru a efectua calcule matematice direct în CSS, combinând unități diferite (px, %, em, vw, etc.).

📌 **Sintaxă:**

```css
proprietate: calc( expresie matematică );
```

---

## **🛠 Exemple practice**

### **1️⃣ Combinarea unităților**

```css
.box {
    width: calc(100% - 50px);
    height: calc(50vh - 20px);
}
```

📌 **Explicație:**

- Lățimea va fi 100% din container **minus 50px**.
- Înălțimea va fi **jumătate din viewport height (vh) - 20px**.

---

### **2️⃣ Operații matematice**

`calc()` suportă:  
✅ **Adunare (`+`)**  
✅ **Scădere (`-`)**  
✅ **Înmulțire (`*`)**  
✅ **Împărțire (`/`)**

```css
.container {
    padding: calc(10px + 2em);
    font-size: calc(1rem * 1.5);
}
```

📌 **Explicație:**

- `padding` combină `px` și `em`.
- `font-size` este de 1.5 ori mai mare decât `1rem`.

---

### **3️⃣ Poziționare flexibilă**

```css
.sidebar {
    width: calc(50vw - 100px);
    left: calc(100% - 300px);
}
```

📌 **Explicație:**

- Sidebar-ul va avea jumătate din lățimea ecranului **minus 100px**.
- `left` îl poziționează exact la **100% din container - 300px**.

---

### **🔹 Reguli importante pentru `calc()`**

1. **Spații obligatorii între operatori!**  
    ❌ `width: calc(100%-50px);` **(Greșit ❌)**  
    ✅ `width: calc(100% - 50px);` **(Corect ✅)**
    
2. **Poate fi folosit în orice proprietate numerică** (width, height, padding, margin, font-size, etc.).
    
3. **Funcționează bine cu variabile CSS (`var(--varName)`)**
    

```css
:root {
    --spacing: 20px;
}

.element {
    margin: calc(var(--spacing) * 2);
}
```

---

### **📌 Rezumat**

✅ `calc()` face calcule dinamice în CSS  
✅ Poate combina **unități diferite** (`px`, `%`, `em`, `vw`, etc.)  
✅ Se poate folosi la **width, height, padding, margin, font-size** etc.  
✅ **Spațiile între operatori sunt obligatorii!**

💡 **Folosește `calc()` pentru layout-uri responsive și flexibile!** 🚀