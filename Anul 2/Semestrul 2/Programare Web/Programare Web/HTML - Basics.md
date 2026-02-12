#### Introduction

- The `<!DOCTYPE html>` declaration defines that this document is an HTML5 document
- The `<html>` element is the root element of an HTML page
- The `<head>` element contains meta information about the HTML page
- The `<title>` element specifies a title for the HTML page (which is shown in the browser's title bar or in the page's tab)
- The `<body>` element defines the document's body, and is a container for all the visible contents, such as headings, paragraphs, images, hyperlinks, tables, lists, etc.
- The `<h1>` element defines a large heading
- The `<p>` element defines a paragraph

#### HTML Page Structure

![[Pasted image 20250302122925.png]]


#### **1. HTML Headings**

- Headings are used to define the structure and hierarchy of content on a webpage.
- HTML provides six levels of headings, from `<h1>` to `<h6>`.
  - `<h1>` is the most important (largest and boldest).
  - `<h6>` is the least important (smallest).
- Example:
  ```html
  <h1>Main Heading</h1>
  <h2>Subheading</h2>
  <h3>Smaller Subheading</h3>
  ```
- Headings are block-level elements and should be used semantically (e.g., `<h1>` for the main title).

#### **2. HTML Paragraphs**

- Paragraphs are used to group blocks of text.
- Defined using the `<p>` tag.
- Example:
  ```html
  <p>This is a paragraph.</p>
  <p>This is another paragraph.</p>
  ```
- Browsers automatically add some margin (space) before and after paragraphs.
- Use `<br>` for line breaks within a paragraph:
  ```html
  <p>This is a line.<br>This is a new line.</p>
  ```
- Use `<hr>` to create a horizontal rule (a thematic break):
  ```html
  <p>This is a paragraph.</p>
  <hr>
  <p>This is another paragraph.</p>
  ```

#### **3. HTML Links**

- Links are used to navigate between pages or sections.
- Defined using the `<a>` tag with the `href` attribute.
- Example:
  ```html
  <a href="https://www.w3schools.com">Visit W3Schools</a>
  ```
- **Attributes**:
  - `href`: Specifies the URL or destination.
  - `target`: Defines where to open the link (e.g., `_blank` opens in a new tab).
    ```html
    <a href="https://www.w3schools.com" target="_blank">Open in New Tab</a>
    ```
  - `title`: Adds a tooltip when hovering over the link.
    ```html
    <a href="https://www.w3schools.com" title="Go to W3Schools">Visit W3Schools</a>
    ```
- **Linking to Sections**:
  - Use the `id` attribute to link to specific sections within a page.
    ```html
    <a href="#section1">Go to Section 1</a>
    <h2 id="section1">Section 1</h2>
    ```
- **Email Links**:
  - Use `mailto:` to create a link that opens the user's email client.
    ```html
    <a href="mailto:example@example.com">Send Email</a>
    ```


#### **4. HTML Images**

- Images are added to web pages using the `<img>` tag.
- The `<img>` tag is self-closing and requires two main attributes:
  - `src`: Specifies the path to the image file.
  - `alt`: Provides alternative text for screen readers or if the image fails to load.
- Example:
  ```html
  <img src="image.jpg" alt="Description of the image">
  ```
- **Additional Attributes**:
  - `width` and `height`: Set the dimensions of the image (in pixels or percentages).
    ```html
    <img src="image.jpg" alt="Description" width="500" height="300">
    ```
  - `title`: Adds a tooltip when hovering over the image.
    ```html
    <img src="image.jpg" alt="Description" title="This is an image">
    ```
- **Linking Images**:
  - Wrap the `<img>` tag inside an `<a>` tag to make the image clickable.
    ```html
    <a href="https://www.example.com">
      <img src="image.jpg" alt="Clickable Image">
    </a>
    ```

