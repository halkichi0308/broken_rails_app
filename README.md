# Broken_Rails_App
![check](https://github.com/halkichi0308/broken_rails_app/actions/workflows/check_docker_build.yml/badge.svg)

## 1. 🚀 Setup

Use docker to launch this application.
```
$cd broken_rails_app

$docker-compose up -d
```

> Note: Did mysql image pull fail? If you use M1/M2 mac. Shoud run below command before docker-compose.
> `docker pull --platform linux/amd64  mysql:5.7`.

than use a browser to access `localhost:3000`

You'll see broken_rails_app page.

**Why using Docker?**: 
We do not recommend running on a host OS because there is no safe way to handle command injection.

## 2. 🎓 Usage

broken_rails_app has some vulnerabiliy. Use various techniques to find out the vulnerability. Use it to validate other SAST and DAST tools.

Can't find the vulnerability?
Take a look at our [tips](https://github.com/halkichi0308/broken_rails_app/blob/master/payloads.md).

## 3. 🔍 Vulnerability

### Format

```
Location of vulnerability

source-sink
filepath or attack vector
```

### 3.1 XSS

-   Stored XSS

```
Reveiw => SUBMIT

source-sink
app/views/review/_list.html.erb
```

-   DOM-Based XSS

```
Reveiw (Direct Access)

source-sink
```

[JavaScript code]

```js
let currentURL = decodeURI(location.href);
let shareURL = document.querySelector("#shareURL");
shareURL.innerHTML = currentURL;
```

### 3.2 OpenRedirect

```
Login => Login

source-sink
app/controllers/User/sessions_controller.rb
```

### 3.3 SQLi

```
products => Purchase

source-sink
app/controllers/cart_controller.rb
```

### 3.4 XXE

```
New Products(admin) => Create Product

source-sink
app/controllers/admin/products_controller.rb
```

### 3.5 CSRF

```
Reveiw => SUBMIT

source-sink
app/controllers/review_controller.rb
```

### 3.6 Directory traversal

```
products => IMAGE DOWNLOAD

source-sink
app/controllers/products_controller.rb
```

### 3.7 OS command Injection

```
products => IMAGE DOWNLOAD

source-sink
app/controllers/products_controller.rb
```

### 3.8 N+1 Problem

```
cart

source
app/controllers/cart_controller.rb
```

---

## 4. ⌛ Test

### 4.1 Setup

```
$ docker-compose -f docker-compose-test.yml up -d
$ docker exec -it rails-test /bin/bash
```

### 4.2 Migration

```
$ RAILS_ENV=test bundle exec rake db:create
$ RAILS_ENV=test bundle exec rake db:migrate
```

### 4.3 Test

```
$ bundle exec rails test
```

### 4.4 SystemTest

```
$ bundle exec rails test:system
```
