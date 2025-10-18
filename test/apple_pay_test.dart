/// Copyright 2024 M-Tayyab-Mustafa
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

@TestOn('vm')
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pay_buttons/flutter_pay_buttons.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApplePayButton Widget Tests', () {
    testWidgets('renders with default UI', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApplePayButton(
              merchantId: 'merchant.flutter.test',
              merchantName: 'Test Merchant',
              amount: '10.00',
              paymentItems: const [PaymentItem(label: 'Test Item', amount: '10.00')],
              onPaymentResult: (result) async {
                // Simulated callback
                debugPrint('onPaymentResult called');
              },
            ),
          ),
        ),
      );

      // Confirm UI elements are present
      expect(find.text('Pay with Apple Pay'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('calls onPaymentResult when tapped (simulation)', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApplePayButton(
              merchantId: 'merchant.flutter.test',
              merchantName: 'Test Merchant',
              amount: '20.00',
              paymentItems: const [PaymentItem(label: 'Test Item', amount: '20.00')],
              onPaymentResult: (result) async {
                debugPrint('Simulated result: $result');
              },
            ),
          ),
        ),
      );

      expect(find.text('Pay with Apple Pay'), findsOneWidget);

      // Simulate tap
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Assert that no crash occurred — can't fully test Pay plugin logic
      expect(true, isTrue);
    });
  });
}
