# Cashblack — Firebase Migratsiya Rejasi

> Maqsad: mavjud Flutter ilovasini tashqi REST API (`https://cashblack.assist.uz/api`) o'rniga
> **to'liq Firebase** backendiga ulab, production holatiga keltirish.
> Tanlangan yondashuv: **Firestore + Cloud Functions** (server mantig'i Functions'da).

---

## 1. Hozirgi holat (qisqacha)

- **Flutter** ilovasi, MVVM (Provider): `views/` + `view_models/` + `core/api/` + `domain/models/`.
- 3 ta rol: **client** (mijoz), **owner/business** (biznes), **seller** (sotuvchi).
- Backend — Dio orqali REST. Bazaviy URL `lib/utils/constants.dart` ichida.
- Auth: telefon + SMS kod, Bearer token `flutter_secure_storage`'da.
- Firebase **hali ulanmagan** (pubspec'da paket yo'q, gradle'da faqat komment).

---

## 2. Endpoint → Firebase moslik jadvali

| Hozirgi REST endpoint | Firebase yechimi |
|---|---|
| `POST /auth/registration` (SMS) | **Firebase Auth** Phone + `onCreate` Functions trigger (Firestore'da user hujjati) |
| `POST /auth/login` (SMS kod) | **Firebase Auth** Phone Auth (`verifyPhoneNumber` → `signInWithCredential`) |
| `GET /v1/owner/profile` | Firestore `users/{uid}` (type=owner) |
| `GET /v1/client/profile` | Firestore `users/{uid}` (type=client) |
| `GET /v1/seller/profile` | Firestore `users/{uid}` (type=seller) |
| `DELETE /v1/*/account_delete` | **Callable Function** (Auth user + Firestore tozalash) |
| `/v1/owner/company`, `/company/logo` | Firestore `companies/{id}` + **Storage** logo |
| `/v1/owner/shop`, `/shop/logo/{id}`, `/v1/owner/shops` | Firestore `shops/{id}` + Storage |
| `/v1/owner/change_shop` | Firestore yangilash (seller→shop bog'lash) |
| `/v1/owner/users`, `/users/{sellerId}` | Firestore `users` (seller yaratish/o'chirish) — **Function** orqali |
| `/v1/owner/category`, `/v1/owner/warehouse/*`, `/v1/unit` | Firestore `warehouses/*`, `categories/*`, `units/*` |
| `/v1/owner/announcement`, `/v1/owner/order`, `/v1/adv` | Firestore `announcements/*`, `orders/*`, `adv/*` |
| `/v1/seller/cashback`, `/v1/owner/seller/cashback` | **Callable Function** `createCashback` (tranzaksiya) |
| `/v1/seller/withdraw`, `/v1/owner/seller/withdraw` | **Callable Function** `createWithdraw` (tranzaksiya) |
| `/v1/seller/client?phone=`, `/v1/owner/seller/client?phone=` | Firestore query `users` (phone bo'yicha) |
| `/v1/report/by-category`, `/by-clients`, `/by-days`, `/cashback` | Firestore aggregatsiya yoki **Functions** hisobot |
| `/v1/client/report/by_category`, `/by_shops` | Firestore query + aggregatsiya |
| `/v1/owner/bonus`, `/v1/prices` | Firestore `config/prices`, `bonuses/*` |
| Bildirishnoma yuborish | **Cloud Functions + FCM** (push) + Firestore `notifications/*` |
| To'lov (MyUzcard) | **Cloud Functions** (server-to-server, kalitlar Functions config'da) |

---

## 3. Firestore ma'lumotlar modeli (sxema)

```
users/{uid}
  phone, nickname, firstName, lastName, type ("owner"|"client"|"seller"),
  districtId, status, balance, total, withdraw, amount,
  companyId (owner uchun), shopId (seller uchun), fcmTokens[], createdAt

companies/{companyId}
  ownerUid, name, logoUrl, inn, address, pinfl, passwordId, districtId, createdAt

shops/{shopId}
  companyId, ownerUid, name, logoUrl, address, waymark, percent,
  categoryShopId, status, createdAt
  shops/{shopId}/sellers/{uid}  -> seller bog'lanishi (yoki users.shopId)

cashbacks/{cashbackId}
  shopId, sellerUid, clientUid, companyId, amount, percent,
  type ("cashback"|"withdraw"|"payment"), createdAt
  // hisobot va balans shu kolleksiyadan hisoblanadi

warehouses/{warehouseId}
  ownerUid, name, ...
  .../categories/{id}, .../products/{id}, .../invoices/{id}, .../providers/{id}

units/{id}, categories/{id}        // umumiy ma'lumotnomalar
provinces/{id}, districts/{id}     // manzil ma'lumotnomalari (seed)

announcements/{id}, orders/{id}, adv/{id}
notifications/{id}  ( toUid, title, body, type, isRead, createdAt )
config/prices, config/bonuses
```

**Muhim:** REST'dagi `int id`lar Firestore'da `string` document ID'ga aylanadi. Modellarning
`fromJson`larida `id`ni `String`ga moslashtirish kerak bo'ladi (yoki `@JsonKey` bilan).

---

## 4. Cloud Functions (server mantig'i)

Sezgir va atomar amallar faqat serverda bajariladi (xavfsizlik uchun):

1. `onUserCreate` — Auth user yaratilganda Firestore `users/{uid}` hujjatini ochadi.
2. `createSeller` (callable) — owner yangi seller qo'shadi (Auth user + Firestore).
3. `createCashback` (callable) — Firestore **transaction**: balanslarni yangilaydi, `cashbacks` yozadi.
4. `createWithdraw` (callable) — keshbek yechib olish, balans tekshiruvi bilan tranzaksiya.
5. `sendNotification` (callable) — owner bildirishnoma yuboradi → FCM push + Firestore yozuv.
6. `topUpBalance` / `confirmPayment` (callable) — **MyUzcard** to'lovi (PDF: `MyUzcard_Payment_Gate_API_v1.3.0.pdf`); kartani serverda qayta ishlash, OTP.
7. `deleteAccount` (callable) — hisob va bog'liq ma'lumotlarni xavfsiz o'chirish.
8. Hisobot funksiyalari (`reportByDays`, `reportByCategory`) — kerak bo'lsa aggregatsiya.

> Eslatma: to'lov/SMS-shlyuz kalitlari `firebase functions:config:set` orqali saqlanadi, ilovaga tushmaydi.

---

## 5. Auth oqimi (telefon)

1. Ilova `FirebaseAuth.verifyPhoneNumber(998XXXXXXXXX)` chaqiradi → SMS keladi.
2. Foydalanuvchi kodni kiritadi → `signInWithCredential` → `uid` olinadi.
3. `onUserCreate` trigger Firestore'da profil ochadi; `type` (owner/client/seller) registratsiyada beriladi.
4. Token o'rniga Firebase ID token avtomatik (Dio header o'rniga `FirebaseAuth` ishlatiladi).
5. Mavjud demo raqamlar (`000000050` va h.k.) uchun Firebase **test phone numbers** sozlanadi.

---

## 6. Security Rules (asosiy tamoyillar)

- `users/{uid}`: faqat egasi o'qiydi/yozadi; balans maydonlari faqat Functions orqali yangilanadi.
- `shops`, `companies`: owner faqat o'zinikini boshqaradi; client o'qiy oladi.
- `cashbacks`: client/seller **yoza olmaydi** — faqat Functions yozadi; o'qish cheklangan.
- Barcha pul bilan bog'liq yozuvlar — `request.auth != null` + Functions orqali.

---

## 7. Bosqichma-bosqich yo'l xaritasi (fazalar)

**Faza 0 — Tayyorgarlik**
- Firebase loyiha yaratish, `flutterfire configure`, `firebase_core` qo'shish.
- Android/iOS/web konfiguratsiya (`google-services.json`, `GoogleService-Info.plist`).

**Faza 1 — Auth**
- `firebase_auth` qo'shish, Phone Auth ulash, `auth_api.dart`ni almashtirish.
- `onUserCreate` Function + registratsiya oqimi.

**Faza 2 — Profil va asosiy ma'lumotlar**
- `client_api.dart`, `business_api.dart`, `seller_api.dart`'dagi GET'larni Firestore'ga ko'chirish.
- Modellarning `fromJson`larini Firestore hujjatlariga moslashtirish (`id` String).

**Faza 3 — Keshbek/to'lov (Functions)**
- `createCashback`, `createWithdraw`, balans tranzaksiyalari.
- Barkod/telefon orqali client topish.

**Faza 4 — Do'kon, kompaniya, sklad, hisobotlar**
- Storage'ga logo yuklash, warehouse CRUD, report query'lar.

**Faza 5 — Bildirishnoma va to'lov shlyuzi**
- FCM push, MyUzcard integratsiyasi (Functions).

**Faza 6 — Production tayyorligi**
- Security rules, indekslar, test raqamlar, App Store/Play Store build, monitoring.

---

## 8. Birinchi qadam uchun tavsiya

Faza 0 + Faza 1 (Auth) — eng to'g'ri boshlanish nuqtasi, chunki butun ilova
auth tokeniga tayanadi. Tayyor bo'lsangiz, Firebase loyihasini yaratib,
`flutterfire configure` bilan ulashdan boshlaymiz.
