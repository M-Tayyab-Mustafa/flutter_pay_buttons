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
  flutter_pay_buttons: ^0.0.3
```

Then, import it:

```dart
import 'package:flutter_pay_buttons/flutter_pay_buttons.dart';
```

---

## 🚀 Quick Start (Apple Pay Example)

```dart
ApplePayButton(
  merchantId: 'merchant.com.example',
  merchantName: 'My Online Store',
  amount: '49.99',
  paymentItems: const [
    PaymentItem(label: 'Total', amount: '49.99'),
  ],
  onPaymentResult: (result) {
    print('Payment result: $result');
  },
)
```

---

## ⚙️ Parameters

| Parameter | Type | Required | Description |
|------------|------|-----------|-------------|
| `merchantId` | `String` | ✅ | The Apple Pay merchant ID. |
| `merchantName` | `String` | ✅ | The display name shown in Apple Pay sheet. |
| `amount` | `String` | ✅ | The total payment amount. |
| `paymentItems` | `List<PaymentItem>` | ✅ | Items displayed in the payment sheet. |
| `onPaymentResult` | `Function(Map<String, dynamic>)` | ✅ | Callback triggered after payment result. |
| `height` | `double?` | ❌ | Custom height of the button. |
| `width` | `double?` | ❌ | Custom width of the button. |
| `margin` | `EdgeInsets?` | ❌ | External padding around the button. |
| `backgroundColor` | `Color?` | ❌ | Background color (default: black). |
| `cornersRadius` | `double?` | ❌ | Corner radius of the button. |
| `child` | `Widget?` | ❌ | Override the default child with custom content. |

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


