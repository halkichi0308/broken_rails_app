# README
## 1. 🚀 Setup
You want to start rails by using docker, following command is enough.

```
$cd broken_rails_app

$docker-compose up -d
```

> Note: Did mysql image pull fail? If you use M1 mac. Shoud run below command before docker-compose.
`docker pull --platform linux/amd64  mysql:5.7`.

than use a browser to access ``localhost:3000``

You'll see broken_rails_app page.


## 2. 🎓 Usage
broken_rails_app has some vulnerabiliy. Use various techniques to find out the vulnerability.


## 3. 🔍 Vulnerability


### 3.1 XSS   
  
```
Reveiw => SUBMIT

source-sink
app/views/review/_list.html.erb
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
___


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
