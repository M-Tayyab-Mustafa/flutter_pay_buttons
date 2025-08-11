# Flutter Pay Buttons Flutter Plugin

A Flutter plugin that adds Flutter Pay Buttons support using the [`pay`](https://pub.dev/packages/pay) package under the hood. This plugin provides a customizable Flutter Pay Buttons and simplifies the integration process.

## Features

- Custom Apple Pay button with styling options
- Uses the reliable `pay` package for handling payment requests
- Easy to integrate in your existing Flutter app

## Getting Started

Before you begin, ensure the following:

- You're developing on a macOS system (Apple Pay is only available on iOS/macOS).
- Your app has the necessary entitlements and configuration for Apple Pay.
- You’ve set up Apple or Google Merchant ID's and certificates in your Apple or Google Developer account.

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_pay_buttons:
    git:
      url: https://github.com/M-Tayyab-Mustafa/flutter_pay_buttons
```

## Payment Data Cryptography

Google Pay encrypts payment information before it leaves the user’s device using industry-standard public key cryptography. When your app receives the payment response, it contains:

- **Encrypted Payment Data** — Sensitive card/payment details
- **Signature** — For verifying data integrity
- **Intermediate Signing Key** — Used to validate the signature

### How Google Pay Encryption Works
1. **Device Encryption** — Google Pay encrypts the payment data using your payment processor’s public key.
2. **Data Transport** — The encrypted blob is returned to your app through the Google Pay API.
3. **Signature Verification** — Your server verifies the signature using the intermediate signing key provided in the response.
4. **Decryption** — Your server decrypts the payment data using your private key.
5. **Processing** — The decrypted details are sent to your payment processor for authorization.

### Important
- **Never** decrypt payment data in the client app.
- Always verify the signature before decryption.
- Keep private keys secure and only on your backend server.

📚 **References:**
- [Google Pay Payment Data Cryptography Guide](https://developers.google.com/pay/api/android/guides/resources/payment-data-cryptography)
- 