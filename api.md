# Business admin

### enter phone number
```json
// POST
// Ilova serverga nomer va type yuboradi (business yoki client).
{
    "phone" : 998973000225,
    "type" : "business"
}
```

### check phone number and verify user
```json
// POST
// Ilova kelgan SMSni serverga yuboradi va tekshiradi.
{
    "sms" : 1234
}
```

### create brand
```json
// POST/UPDATE
// Brend tuzish yoki oʻzgartirish.
{
    "name" : "Brand Name", // unique,
    "logo" : "image", // rasm
    "cashback" : 1.5, // cashback foizi
    "province" : "province_id",
    "city" : "city_id"
}
```

### edit phone number
```json
// UPDATE
// Register boʻlgan user nomerini oʻzgartirish
{
    "phone" : 998973000225,
}
```

### create employee
```json
// POST/UPDATE
// Sotrudnik qoʻshish
{
    "phone" : 998973000225,
    "name" : "Ism Familiya"
}
```

### delete employee
```json
// DELETE
// Sotrudnikni oʻchirish
{
    "phone" : 998973000225,
    "name" : "Ism Familiya"
}
```

### balansni koʻrsatish
```json
// GET
{
    "amount" : 123456789 // pul miqdori
}
```

### balansni toʻldirish
```json
// POST
{
    "card" : 8600000000000000,
    "date" : "12/22",
    "amount" : 123456789 // pul miqdori
}
```

### balansni toʻldirishlar tarixi
```json
// GET
{
    "data" : [
        {
            "data" : "12.12.2022 12:12",
            "amount" : 123456789 // pul miqdori
        },
        {
            "data" : "12.12.2022 12:12",
            "amount" : 123456789 // pul miqdori
        }
    ]
}
```


### klient pul berib sotib olgan narsalar
```json
// GET
{
    "data" : [
        {
            "data" : "12.12.2022 12:12",
            "amount" : 123456789 // pul miqdori
        },
        {
            "data" : "12.12.2022 12:12",
            "amount" : 123456789 // pul miqdori
        }
    ]
}
```
