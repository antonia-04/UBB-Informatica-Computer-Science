| Tag            | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| `<abbr>`       | Defines an abbreviation or acronym                             |
| `<address>`    | Defines contact information for the author/owner of a document |
| `<bdo>`        | Defines the text direction                                     |
| `<blockquote>` | Defines a section that is quoted from another source           |
| `<cite>`       | Defines the title of a work                                    |
| `<q>`          | Defines a short inline quotation                               |


#### **1. `<abbr>` - Abbreviation or Acronym**
- **Description**: Defines an abbreviation or acronym. Use the `title` attribute to provide the full form.
- **Example**:
  ```html
  <p>The <abbr title="World Health Organization">WHO</abbr> was founded in 1948.</p>
  ```


#### **2. `<address>` - Contact Information**
- **Description**: Defines contact information for the author or owner of a document. Typically rendered in italics.
- **Example**:
  ```html
  <address>
    Written by John Doe.<br>
    Visit us at:<br>
    Example.com<br>
    Box 123, City<br>
    Country
  </address>
  ```


#### **3. `<bdo>` - Bi-Directional Override**
- **Description**: Overrides the default text direction. Use the `dir` attribute to specify direction (`ltr` for left-to-right or `rtl` for right-to-left).
- **Example**:
  ```html
  <p><bdo dir="rtl">This text will be written from right to left.</bdo></p>
  ```


#### **4. `<blockquote>` - Block Quotation**
- **Description**: Defines a section that is quoted from another source. Browsers typically indent it.
- **Example**:
  ```html
  <blockquote cite="https://example.com">
    This is a long quotation from another source.
  </blockquote>
  ```


#### **5. `<cite>` - Title of a Work**
- **Description**: Defines the title of a creative work (e.g., a book, poem, song, movie). Typically rendered in italics.
- **Example**:
  ```html
  <p><cite>The Mona Lisa</cite> was painted by Leonardo da Vinci.</p>
  ```


#### **6. `<q>` - Short Inline Quotation**
- **Description**: Defines a short inline quotation. Browsers usually add quotation marks around the text.
- **Example**:
  ```html
  <p>She said, <q>This is a short quote.</q></p>
  ```


Here’s a summary of **HTML Comments** based on W3Schools:


### **HTML Comments**

- HTML comments are used to add notes or explanations within the code that are not displayed in the browser.
- Comments are ignored by the browser and are only visible in the source code.

#### **Syntax**
- HTML comments start with `<!--` and end with `-->`.
- Example:
  ```html
  <!-- This is a comment -->
  <p>This is a paragraph.</p>
  ```


#### **Multi-Line Comments**

- Comments can span multiple lines.
- Example:
  ```html
  <!--
    This is a multi-line comment.
    It can span several lines.
  -->
  <p>This is a paragraph.</p>
  ```


#### **Commenting Out Code**
- Comments can be used to temporarily disable parts of the code.
- Example:
  ```html
  <p>This is a paragraph.</p>
  <!-- <p>This paragraph is commented out.</p> -->
  ```


#### **Conditional Comments (Deprecated)**
- Conditional comments were used in older versions of Internet Explorer to target specific versions of the browser.
- They are **no longer supported** in modern browsers.
- Example (for historical reference):
  ```html
  <!--[if IE 8]>
    <p>This is only shown in Internet Explorer 8.</p>
  <![endif]-->
  ```
