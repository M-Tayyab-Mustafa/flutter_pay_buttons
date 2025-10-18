# 🪙 Flutter Pay Buttons

A modern, customizable Flutter plugin that provides **ready-made Pay buttons** — including **Apple Pay**, **Google Pay**, and more — using a simple, developer-friendly API.

[![pub package](https://img.shields.io/pub/v/flutter_pay_buttons.svg)](https://pub.dev/packages/flutter_pay_buttons)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Flutter](https://img.shields.io/badge/Flutter-%E2%9D%A4-blue.svg)](https://flutter.dev)

---

## ✨ Features

✅ Prebuilt buttons for **Apple Pay**, **Google Pay**, etc.  
✅ Fully customizable UI (color, radius, text, child widget).  
✅ Built on top of the official [`pay`](https://pub.dev/packages/pay) package.  
✅ Simple callback for handling payment results.  
✅ Scalable and responsive with `pr`, `sp`, and `ScaledEdgeInsets`.

---

## 📦 Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_pay_buttons: ^0.0.4
```

Then, import it:

```dart
import 'package:flutter_pay_buttons/flutter_pay_buttons.dart';
```

---

## 🚀 Quick Start (Apple Pay Example)

```dart
ApplePayButton(
  merchantId: 'merchant.YOUR_MERCHANT_ID',
  merchantName: 'Example Merchant',
  amount: '49.99',
  paymentItems: const [
    PaymentItem(label: 'Product', amount: '49.99', status: PaymentItemStatus.final_price, type: PaymentItemType.item),
    PaymentItem(label: 'Total', amount: '49.99', status: PaymentItemStatus.final_price),
  ],
  onPaymentResult: (result) {
    print('Payment result: $result');
  },
)
```
---

## 🚀 Quick Start (Google Pay Example)

```dart
GooglePayButton(
 totalPrice: '10.00',
 merchantId: 'YOUR_MERCHANT_ID',
 merchantName: 'Example Merchant',
 publicKey: 'YOUR_PUBLIC_KEY_HERE',
 tokenizationSpecificationType: TokenizationSpecificationType.direct,
 isTesting: true,
 paymentItems: [PaymentItem(label: 'Total', amount: '99.99', status: PaymentItemStatus.final_price)],
 onPaymentResult: (result) {
  debugPrint('Payment Result: $result');
 },
)
```

---

## ⚙️ Parameters (Apple Pay)

| Parameter | Type | Required | Description |
|------------|------|-----------|-------------|
| `merchantId` | `String` | ✅ | The Apple Pay merchant ID. |
| `merchantName` | `String` | ✅ | The display name shown in the Apple Pay sheet. |
| `amount` | `String` | ✅ | The total payment amount for the transaction. |
| `paymentItems` | `List<PaymentItem>` | ✅ | List of payment items displayed in the Apple Pay sheet. |
| `onPaymentResult` | `Function(Map<String, dynamic>)` | ✅ | Callback triggered after receiving the Apple Pay result. |
| `height` | `double?` | ❌ | Custom height of the button. |
| `width` | `double?` | ❌ | Custom width of the button (must be at least 220). |
| `margin` | `EdgeInsets?` | ❌ | External padding around the button. |
| `backgroundColor` | `Color?` | ❌ | Background color of the Apple Pay button. |
| `cornersRadius` | `double?` | ❌ | Corner radius of the button for rounded edges. |
| `merchantCapabilities` | `List<MerchantCapability>?` | ❌ | Supported merchant capabilities (e.g. `3DS`, `Credit`, `Debit`). |
| `supportedNetworks` | `List<ApplePaySupportedNetwork>?` | ❌ | Supported card networks for Apple Pay (e.g. `visa`, `masterCard`). |
| `countryCode` | `String?` | ❌ | The ISO country code (e.g. `US`, `PK`). |
| `currencyCode` | `String?` | ❌ | The currency code used for the transaction (e.g. `USD`, `PKR`). |
| `requiredBillingContactFields` | `List<ApplePayContactFields>?` | ❌ | Fields required for billing contact information. |
| `requiredShippingContactFields` | `List<ApplePayContactFields>?` | ❌ | Fields required for shipping contact information. |
| `mainAxisAlignment` | `MainAxisAlignment` | ❌ | Alignment of content inside the button row. |
| `mainAxisSize` | `MainAxisSize` | ❌ | Layout size behavior of the button (default: `MainAxisSize.min`). |
| `child` | `Widget?` | ❌ | Custom widget to replace the default Apple Pay button UI. |

---

## ⚙️ Parameters (Google Pay)

| Parameter | Type | Required | Description |
|------------|------|-----------|-------------|
| `merchantId` | `String` | ✅ | The Google Pay merchant ID. |
| `merchantName` | `String` | ✅ | The merchant name displayed in the payment sheet. |
| `totalPrice` | `String` | ✅ | The total transaction amount. |
| `paymentItems` | `List<PaymentItem>` | ✅ | List of payment items shown in the Google Pay sheet. |
| `onPaymentResult` | `Function(Map<String, dynamic>)` | ✅ | Callback triggered when the payment result is received. |
| `height` | `double?` | ❌ | Custom height of the button. |
| `width` | `double?` | ❌ | Custom width of the button (must be at least 220). |
| `margin` | `EdgeInsets?` | ❌ | External padding around the button. |
| `backgroundColor` | `Color?` | ❌ | Background color of the button. |
| `cornersRadius` | `double?` | ❌ | Corner radius for rounded edges. |
| `isTesting` | `bool` | ❌ | Enable testing mode for Google Pay. |
| `checkoutOption` | `CheckoutOption` | ❌ | Determines when payment is processed (e.g. `CheckoutOption.lazy`). |
| `apiVersion` | `int?` | ❌ | Google Pay API version (optional). |
| `apiVersionMinor` | `int?` | ❌ | Minor API version for Google Pay. |
| `allowedCardNetworks` | `List<CardNetwork>?` | ❌ | List of supported card networks (e.g. VISA, MASTERCARD). |
| `billingAddressRequired` | `bool` | ❌ | Whether billing address is required. |
| `billingAddressFormat` | `BillingAddressFormat?` | ❌ | Format of the billing address (e.g. `FULL`, `MIN`). |
| `phoneNumberRequired` | `bool` | ❌ | Whether phone number collection is required. |
| `tokenizationSpecificationType` | `TokenizationSpecificationType` | ❌ | Defines how payment data is tokenized (`direct` or `paymentGateway`). |
| `tokenizationSpecificationParameters` | `Map<String, dynamic>?` | ❌ | Parameters required when using `paymentGateway` tokenization. |
| `publicKey` | `String?` | ❌ | Public key used for direct tokenization. |
| `currencyCode` | `String?` | ❌ | Currency code (e.g. `USD`, `PKR`). |
| `transactionInfoStatus` | `TransactionInfoStatus?` | ❌ | Status type for the transaction (e.g. `FINAL`, `ESTIMATED`). |
| `child` | `Widget?` | ❌ | Custom child widget to override the default button content. |
| `mainAxisAlignment` | `MainAxisAlignment` | ❌ | Alignment of content inside the button row. |
| `mainAxisSize` | `MainAxisSize` | ❌ | Layout size behavior of the button (default: `MainAxisSize.min`). |

---

## 🧠 How It Works

1. Internally, `ApplePayButton` builds a configuration JSON for the [`pay`](https://pub.dev/packages/pay) package.  
2. When tapped, it calls `showPaymentSelector()` to display the Apple Pay sheet.  
3. The result (success, error, or cancellation) is returned via the `onPaymentResult` callback.  

---

## 🎨 Customizing the Button

You can replace the default layout with your own widget:

```dart
ApplePayButton(
  merchantId: 'merchant.com.example',
  merchantName: 'Custom Shop',
  amount: '29.99',
  paymentItems: const [
    PaymentItem(label: 'Shoes', amount: '29.99'),
  ],
  onPaymentResult: (result) => print(result),
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.apple, color: Colors.white),
        SizedBox(width: 8),
        Text('Buy with Apple Pay', style: TextStyle(color: Colors.white)),
      ],
    ),
  ),
)
```

## 💙 Author

**M-Tayyab-Mustafa**  
📧 m.tayyabmustafa.joiya@gmail.com  
🌐 [github.com/M-Tayyab-Mustafa](https://github.com/M-Tayyab-Mustafa)

---

## 💡 Notes

- Make sure to configure your **Merchant ID**.  
- Always test on a **real device** (Apple Pay is not supported in simulators).  

---

**Made with ❤️ in Flutter**


