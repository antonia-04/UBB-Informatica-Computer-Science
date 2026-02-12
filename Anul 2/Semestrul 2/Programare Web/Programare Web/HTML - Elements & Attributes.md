

#### **1. HTML Elements Overview**

- An HTML element is a component of an HTML document that defines the structure and content of a webpage.
- Elements are represented by **tags**, which are enclosed in angle brackets (`< >`).
- Most elements have an **opening tag** and a **closing tag**, with content in between.
  - Example: `<p>This is a paragraph.</p>`
- Some elements are **self-closing** and do not have a closing tag.
  - Example: `<img src="image.jpg" alt="Image">`


#### **2. Basic HTML Elements**

1. **Headings**:
   - `<h1>` to `<h6>`: Define headings of different levels.
   - Example: `<h1>Main Title</h1>`

2. **Paragraphs**:
   - `<p>`: Defines a paragraph of text.
   - Example: `<p>This is a paragraph.</p>`

3. **Links**:
   - `<a>`: Creates a hyperlink.
   - Example: `<a href="https://example.com">Visit Example</a>`

4. **Images**:
   - `<img>`: Embeds an image.
   - Example: `<img src="image.jpg" alt="Description">`

5. **Lists**:
   - `<ul>`: Unordered list (bullet points).
   - `<ol>`: Ordered list (numbered).
   - `<li>`: List item.
   - Example:
     ```html
     <ul>
       <li>Item 1</li>
       <li>Item 2</li>
     </ul>
     ```

6. **Divisions and Spans**:
   - `<div>`: Block-level container for grouping elements.
   - `<span>`: Inline container for styling or grouping text.
   - Example:
     ```html
     <div>This is a block container.</div>
     <span>This is inline text.</span>
     ```

7. **Forms**:
   - `<form>`: Creates a form for user input.
   - `<input>`: Defines an input field.
   - Example:
     ```html
     <form>
       <input type="text" placeholder="Enter your name">
     </form>
     ```

8. **Tables**:
   - `<table>`: Defines a table.
   - `<tr>`: Table row.
   - `<td>`: Table data (cell).
   - Example:
     ```html
     <table>
       <tr>
         <td>Row 1, Cell 1</td>
         <td>Row 1, Cell 2</td>
       </tr>
     </table>
     ```

9. **Semantic Elements**:
   - `<header>`: Represents the header of a section or page.
   - `<footer>`: Represents the footer of a section or page.
   - `<section>`: Defines a section of content.
   - `<article>`: Represents independent, self-contained content.
   - Example:
     ```html
     <header>This is a header.</header>
     <section>This is a section.</section>
     <footer>This is a footer.</footer>
     ```


#### **3. Self-Closing Elements**
- Elements that do not have closing tags:
  - `<img>`: For images.
  - `<br>`: Line break.
  - `<hr>`: Horizontal rule.
  - `<input>`: Input fields.
  - Example: `<br>`


#### **4. Attributes**

- All HTML elements can have **attributes**
- The `href` attribute of `<a>` specifies the URL of the page the link goes to
- The `src` attribute of `<img>` specifies the path to the image to be displayed
- The `width` and `height` attributes of `<img>` provide size information for images
- The `alt` attribute of `<img>` provides an alternate text for an image
- The `style` attribute is used to add styles to an element, such as color, font, size, and more
- The `lang` attribute of the `<html>` tag declares the language of the Web page
- The `title` attribute defines some extra information about an element



##### **1. `style` Attribute**
- The `style` attribute is used to apply **inline CSS styles** directly to an HTML element.
- It allows you to control properties like color, font, size, alignment, and more.
- Example:
  ```html
  <p style="color: red; font-size: 20px;">This is a styled paragraph.</p>
  ```
- **Common Properties**:
  - `color`: Sets text color.
  - `font-size`: Controls the size of the text.
  - `background-color`: Sets the background color of an element.
  - `text-align`: Aligns text (left, right, center, justify).
  - `margin` and `padding`: Control spacing around elements.


##### **2. `lang` Attribute**

- The `lang` attribute specifies the **language of the content** within an element.
- It is commonly used in the `<html>` tag to declare the language of the entire webpage.
- Helps screen readers and search engines understand the language of the content.
- Example:
  ```html
  <html lang="en">
    <body>
      <p>This page is in English.</p>
    </body>
  </html>
  ```
- **Language Codes**:
  - `en` for English.
  - `es` for Spanish.
  - `fr` for French.
  - `de` for German.


##### **3. `title` Attribute**

- The `title` attribute provides **additional information** about an element.
- When a user hovers over the element, the text in the `title` attribute is displayed as a tooltip.
- Useful for adding context or descriptions to links, images, or other elements.
- Example:
  ```html
  <a href="https://example.com" title="Visit Example Website">Click here</a>
  <img src="image.jpg" alt="Description" title="This is an image">
  ```


##### **4. `href` Attribute**

- The `href` attribute is used in the `<a>` tag to specify the **destination URL** of a hyperlink.
- It can link to external websites, internal pages, or specific sections within a page.
- Example:
  ```html
  <a href="https://www.w3schools.com">Visit W3Schools</a>
  <a href="#section1">Go to Section 1</a>
  ```


##### **5. `src` Attribute**

- The `src` attribute is used in elements like `<img>`, `<script>`, and `<iframe>` to specify the **source file**.
- For images, it defines the path to the image file.
- Example:
  ```html
  <img src="image.jpg" alt="Description">
  <script src="script.js"></script>
  ```


##### **6. `alt` Attribute**

- The `alt` attribute provides **alternative text** for images.
- It is displayed if the image fails to load and is used by screen readers for accessibility.
- Example:
  ```html
  <img src="image.jpg" alt="A beautiful landscape">
  ```


##### **7. `width` and `height` Attributes**

- The `width` and `height` attributes specify the **dimensions** of an image or other elements.
- Values can be in pixels (`px`) or percentages (`%`).
- Example:
  ```html
  <img src="image.jpg" alt="Description" width="500" height="300">
  ```



##### **8. Other Common Attributes**

- **`id`**: Assigns a unique identifier to an element.
  ```html
  <div id="header">This is the header.</div>
  ```
- **`class`**: Assigns one or more class names to an element for styling or scripting.
  ```html
  <p class="highlight">This is a highlighted paragraph.</p>
  ```
- **`target`**: Specifies where to open a linked document (e.g., `_blank` opens in a new tab).
  ```html
  <a href="https://example.com" target="_blank">Open in New Tab</a>
  ```
