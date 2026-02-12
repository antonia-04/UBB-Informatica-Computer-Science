
#### **HTML Colors**
- Colors in HTML can be specified using:
  1. **Color Names** (e.g., `red`, `blue`, `green`).
  2. **Hexadecimal Values** (e.g., `#FF0000` for red).
  3. **RGB Values** (e.g., `rgb(255, 0, 0)` for red).
  4. **RGBA Values** (e.g., `rgba(255, 0, 0, 0.5)` for semi-transparent red).
  5. **HSL Values** (e.g., `hsl(0, 100%, 50%)` for red).
  6. **HSLA Values** (e.g., `hsla(0, 100%, 50%, 0.5)` for semi-transparent red).


#### **1. Color Names**
- HTML supports 140 standard color names.
- Example:
  ```html
  <p style="color: red;">This text is red.</p>
  <p style="background-color: blue;">This background is blue.</p>
  ```


#### **2. Hexadecimal Values**

- Colors are represented as a combination of **red, green, and blue (RGB)** in hexadecimal format.
- Format: `#RRGGBB`, where `RR`, `GG`, and `BB` are hexadecimal values (00 to FF).
- Example:
  ```html
  <p style="color: #FF0000;">This text is red.</p>
  <p style="background-color: #0000FF;">This background is blue.</p>
  ```


#### **3. RGB Values**
- Colors are defined using the `rgb()` function, which takes three values for red, green, and blue (0 to 255).
- Example:
  ```html
  <p style="color: rgb(255, 0, 0);">This text is red.</p>
  <p style="background-color: rgb(0, 0, 255);">This background is blue.</p>
  ```

#### **4. RGBA Values**
- Similar to RGB but includes an **alpha channel** for transparency (0 = fully transparent, 1 = fully opaque).
- Example:
  ```html
  <p style="color: rgba(255, 0, 0, 0.5);">This text is semi-transparent red.</p>
  <p style="background-color: rgba(0, 0, 255, 0.3);">This background is semi-transparent blue.</p>
  ```


#### **5. HSL Values**

- Colors are defined using **hue, saturation, and lightness**:
  - **Hue**: A degree on the color wheel (0 = red, 120 = green, 240 = blue).
  - **Saturation**: Percentage (0% = gray, 100% = full color).
  - **Lightness**: Percentage (0% = black, 100% = white).
- Example:
  ```html
  <p style="color: hsl(0, 100%, 50%);">This text is red.</p>
  <p style="background-color: hsl(240, 100%, 50%);">This background is blue.</p>
  ```


#### **6. HSLA Values**
- Similar to HSL but includes an **alpha channel** for transparency (0 = fully transparent, 1 = fully opaque).
- Example:
  ```html
  <p style="color: hsla(0, 100%, 50%, 0.5);">This text is semi-transparent red.</p>
  <p style="background-color: hsla(240, 100%, 50%, 0.3);">This background is semi-transparent blue.</p>
  ```


#### **Common Uses of Colors in HTML**

1. **Text Color**:
   ```html
   <p style="color: green;">This text is green.</p>
   ```
2. **Background Color**:
   ```html
   <p style="background-color: yellow;">This background is yellow.</p>
   ```
3. **Border Color**:
   ```html
   <p style="border: 2px solid purple;">This has a purple border.</p>
   ```

