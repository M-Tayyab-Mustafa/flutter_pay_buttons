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

part of '../flutter_pay_buttons.dart';

/// This getter provides an SVG image of the Apple logo as raw byte data.
///
/// The image is stored as an inline SVG string, and then encoded into a
/// `Uint8List` so it can be used in Flutter widgets (e.g., displaying an icon).
///
/// Here's how it works:
/// - The SVG markup is stored as a raw string using triple quotes (`'''...'''`)
/// - The `utf8.encode()` function converts the string into a list of bytes
/// - `Uint8List.fromList()` turns that list of bytes into a typed byte array,
///   which Flutter can use to render images, especially when using something
///   like `Image.memory()`
///
/// Example usage:
/// ```dart
/// Image.memory(_appleLogoSvgBytes)
/// ```
Uint8List get _appleLogoSvgBytes => Uint8List.fromList(
  utf8.encode('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 847 1000">
  <path fill="#FFFFFF" d="M666.3 531.2c-0.4-85.3 69.8-126.3 73-128.3-39.8-58.1-101.6-66-123.5-66.8-52.6-5.3-102.5 30.9-129.2 30.9-26.7 0-68.1-30.1-111.9-29.3-57.6 0.8-111.4 33.4-141.2 84.6-60.1 104.1-15.3 258.1 42.8 342.6 28.3 40.8 61.9 86.5 106 84.8 42.5-1.7 58.5-27.5 109.8-27.5 51.3 0 65.3 27.5 110 26.7 45.6-0.8 74.6-41.7 102.8-82.5 32.2-47 45.4-92.4 45.8-94.7-1.1-0.5-88-33.8-88.4-134.5zM577.5 221.4c23.6-28.6 39.5-68.5 35.2-108.4-34 1.4-75.3 22.6-99.6 51.1-21.8 25.2-40.9 65.3-35.8 103.7 37.9 2.9 76.9-19.2 100.2-46.4z"/>
</svg>
'''),
);

/// Shows the Apple Pay payment sheet to the user.
///
/// This line triggers the `pay` plugin to display the Apple Pay payment UI,
/// using the configuration and payment items provided.
///
/// Internally, it calls the `showPaymentSelector()` method from the `Pay` class,
/// which:
/// - Opens the Apple Pay interface (on iOS)
/// - Uses the payment details defined in `paymentItems`
/// - Returns the result of the transaction (such as success, failure, or cancellation)
///
/// ### Parameters:
/// - `PayProvider.flutter_pay_buttons`: Tells the plugin to use Apple Pay as the payment method.
/// - `widget.paymentItems`: A list of items showing what the user is paying for
///   (e.g., product names, totals).
///
/// ### Example of what's happening:
/// ```dart
/// final result = await _pay.showPaymentSelector(
///   PayProvider.flutter_pay_buttons,
///   [
///     PaymentItem(label: 'Total', amount: '49.99'),
///   ],
/// );
/// ```
///
/// ### Result:
/// The `result` is a `Map<String, dynamic>` containing information about the
/// outcome of the payment. It's passed to the `onPaymentResult()` callback:
///
/// ```dart
/// widget.onPaymentResult(result);
/// ```

class ApplePayButton extends StatefulWidget {
  const ApplePayButton({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.backgroundColor,
    this.cornersRadius,
    required this.merchantId,
    required this.merchantName,
    required this.amount,
    this.merchantCapabilities,
    this.supportedNetworks,
    this.countryCode,
    this.currencyCode,
    required this.paymentItems,
    this.requiredBillingContactFields,
    this.requiredShippingContactFields,
    required this.onPaymentResult,
    this.child,
  });

  // UI customization
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? cornersRadius;
  final Widget? child;

  // Payment-related fields
  final String merchantId;
  final String merchantName;
  final String amount;
  final List<String>? merchantCapabilities;
  final List<String>? supportedNetworks;
  final String? countryCode;
  final String? currencyCode;
  final List<PaymentItem> paymentItems;
  final List<String>? requiredBillingContactFields;
  final List<String>? requiredShippingContactFields;

  // Callback for payment result
  final FutureOr<void> Function(Map<String, dynamic> result) onPaymentResult;

  @override
  State<ApplePayButton> createState() => _ApplePayButtonState();
}

class _ApplePayButtonState extends State<ApplePayButton> {
  // Creates the Apple Pay configuration required by the 'pay' plugin
  Map<PayProvider, PaymentConfiguration> get _configurations => {
    PayProvider.apple_pay: PaymentConfiguration.fromJsonString(
      jsonEncode({
        "provider": "apple_pay",
        "data": {
          "merchantIdentifier": widget.merchantId,
          "displayName": widget.merchantName,
          "merchantCapabilities": widget.merchantCapabilities ?? ["3DS", "debit", "credit"],
          "supportedNetworks": widget.supportedNetworks ?? ["amex", "visa", "discover", "masterCard"],
          "countryCode": widget.countryCode ?? "US",
          "currencyCode": widget.currencyCode ?? "USD",
          "requiredBillingContactFields": widget.requiredBillingContactFields ?? [],
          "requiredShippingContactFields": widget.requiredShippingContactFields ?? [],
        },
      }),
    ),
  };

  // Initializes the Pay client with the configuration
  Pay get _pay => Pay(_configurations);

  // Default button height if user hasn't set one
  Size get _buttonSize => Size(210, 40);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) return const SizedBox.shrink();
    return Padding(
      // Applies external spacing to the button
      padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        // Handles tap event to start the Apple Pay flow
        onTap: () async {
          try {
            // Shows the Apple Pay sheet with the payment items
            final result = await _pay.showPaymentSelector(PayProvider.apple_pay, widget.paymentItems);

            // Calls the user-defined callback with the result
            return widget.onPaymentResult(result);
          } catch (e) {
            // Prints error in red if something goes wrong
            debugPrint('\x1B[31m [Apple Pay] Error: $e \x1B[0m');
          }
        },
        child:
            widget.child ??
            Container(
              height: widget.height?.pr ?? _buttonSize.height.pr,
              width: widget.width?.pr ?? _buttonSize.width.pr,
              padding: ScaledEdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: widget.backgroundColor ?? Colors.black, borderRadius: BorderRadius.circular(widget.cornersRadius?.pr ?? 10.pr)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Displays Google logo using SVG
                  SvgPicture.memory(_appleLogoSvgBytes, height: 25.pr, width: 25.pr),
                  // Adds space between logo and text
                  Padding(
                    padding: ScaledEdgeInsets.only(left: 10),
                    child: Text(
                      'Pay with Apple Pay',
                      style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5.sp, wordSpacing: 1.sp),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
