import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pay_buttons/flutter_pay_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pay Example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Platform.isIOS)
              ApplePayButton(
                merchantId: 'YOUR_MERCHANT_ID',
                merchantName: 'Example Merchant',
                amount: '99.00',
                paymentItems: [
                  // Example payment items
                  PaymentItem(label: 'Product', amount: '99.99', status: PaymentItemStatus.final_price, type: PaymentItemType.item),
                  // Total amount
                  PaymentItem(label: 'Total', amount: '99.99', status: PaymentItemStatus.final_price),
                ],
                margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                onPaymentResult: (result) {
                  debugPrint('Payment Result: $result');
                },
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
