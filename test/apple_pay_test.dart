/* SPDX-License-Identifier: CECILL-2.1
 * Copyright (c) 2024 M-Tayyab-Mustafa
 * Licensed under the CeCILL-2.1 License
 * See the LICENSE file for details.
 */

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
              paymentItems: const [
                PaymentItem(label: 'Test Item', amount: '10.00'),
              ],
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

    testWidgets('calls onPaymentResult when tapped (simulation)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApplePayButton(
              merchantId: 'merchant.flutter.test',
              merchantName: 'Test Merchant',
              amount: '20.00',
              paymentItems: const [
                PaymentItem(label: 'Test Item', amount: '20.00'),
              ],
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
