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

/// This getter provides an SVG image of the Google logo as raw byte data.
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
/// Image.memory(_googleLogoSvgBytes)
/// ```
Uint8List get _googleLogoSvgBytes => Uint8List.fromList(
  utf8.encode('''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <!-- Blue (shifted ~0.7% right and down) -->
  <path fill="#4285F4" transform="translate(0.17,0.17)" d="M23.7 12.25c0-.85-.07-1.67-.21-2.45H12v4.6h6.25c-.3 1.5-1.15 2.77-2.48 3.63v2.95h4.05c2.34-2.17 3.88-5.35 3.88-8.73z"/>
  
  <!-- Green -->
  <path fill="#34A853" d="M12 24c3.24 0 5.96-1.07 7.95-2.91l-3.87-2.81c-1.08.73-2.47 1.16-4.08 1.16-3.14 0-5.8-2.12-6.75-4.97H1.26v3.1C3.23 21.3 7.31 24 12 24z"/>
  
  <!-- Yellow -->
  <path fill="#FBBC05" d="M5.25 14.47a7.97 7.97 0 0 1 0-4.94V6.43H1.26a12.02 12.02 0 0 0 0 11.14l3.99-3.1z"/>
  
  <!-- Red -->
  <path fill="#EA4335" d="M12 4.77c1.76 0 3.35.61 4.6 1.81l3.43-3.43C17.94 1.2 15.24 0 12 0 7.31 0 3.23 2.7 1.26 6.43l3.99 3.1C6.2 6.89 8.86 4.77 12 4.77z"/>
</svg>'''),
);

/// Shows the Google Pay payment sheet to the user.
///
/// This line triggers the `pay` plugin to display the Google Pay payment UI,
/// using the configuration and payment items provided.
///
/// Internally, it calls the `showPaymentSelector()` method from the `Pay` class,
/// which:
/// - Opens the Google Pay interface (on iOS)
/// - Uses the payment details defined in `paymentItems`
/// - Returns the result of the transaction (such as success, failure, or cancellation)
///
/// ### Parameters:
/// - `PayProvider.flutter_pay_buttons`: Tells the plugin to use Google Pay as the payment method.
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

class GooglePayButton extends StatefulWidget {
  const GooglePayButton({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.backgroundColor,
    this.cornersRadius,
    required this.onPaymentResult,
    this.isTesting = false,
    required this.paymentItems,
    this.checkoutOption = CheckoutOption.lazy,
    this.apiVersion,
    this.apiVersionMinor,
    this.allowedCardNetworks,
    this.billingAddressRequired = false,
    this.billingAddressFormat,
    this.phoneNumberRequired = false,
    this.tokenizationSpecificationType = TokenizationSpecificationType.direct,
    this.tokenizationSpecificationParameters,
    this.publicKey,
    this.currencyCode,
    this.transactionInfoStatus,
    required this.totalPrice,
    required this.merchantId,
    required this.merchantName,
    this.child,
  }) : assert(
         !(tokenizationSpecificationType == TokenizationSpecificationType.paymentGateway && tokenizationSpecificationParameters == null),
         'Invalid tokenization specification: tokenizationSpecificationParameters are required when type is set to paymentGateway',
       );

  // UI customization
  final double? height;
  final double? width;
  final ScaledEdgeInsets? margin;
  final Color? backgroundColor;
  final double? cornersRadius;
  final Widget? child;

  // Payment-related fields
  final bool isTesting;
  final List<PaymentItem> paymentItems;
  final int? apiVersion;
  final int? apiVersionMinor;
  final List<String>? allowedCardNetworks;
  final bool billingAddressRequired;
  final String? billingAddressFormat;
  final bool phoneNumberRequired;
  final TokenizationSpecificationType tokenizationSpecificationType;
  final Map<String, dynamic>? tokenizationSpecificationParameters;
  final String? publicKey;
  final String? currencyCode;
  final TransactionInfoStatus? transactionInfoStatus;
  final String totalPrice;
  final CheckoutOption checkoutOption;
  final String merchantId;
  final String merchantName;

  // Callback for payment result
  final FutureOr<void> Function(Map<String, dynamic> result) onPaymentResult;

  @override
  State<GooglePayButton> createState() => _GooglePayButtonState();
}

class _GooglePayButtonState extends State<GooglePayButton> {
  // Creates the Google Pay configuration required by the 'pay' plugin
  Map<PayProvider, PaymentConfiguration> get _configurations => {
    PayProvider.google_pay: PaymentConfiguration.fromJsonString(
      jsonEncode({
        "provider": "google_pay",
        "data": {
          "environment": widget.isTesting ? "TEST" : "PRODUCTION",
          "apiVersion": widget.apiVersion ?? 2,
          "apiVersionMinor": widget.apiVersionMinor ?? 0,
          "allowedPaymentMethods": [
            {
              "type": "CARD",
              "parameters": {
                "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
                "allowedCardNetworks": widget.allowedCardNetworks ?? ["MASTERCARD", "VISA", "AMEX", "DISCOVER", "INTERAC", "JCB"],
                "assuranceDetailsRequired": true,
                "billingAddressRequired": widget.billingAddressRequired,
                "billingAddressParameters": {"format": widget.billingAddressFormat ?? "FULL", "phoneNumberRequired": widget.phoneNumberRequired},
              },
              "tokenizationSpecification": {
                "type": widget.tokenizationSpecificationType.value,
                "parameters": switch (widget.tokenizationSpecificationType) {
                  TokenizationSpecificationType.paymentGateway => widget.tokenizationSpecificationParameters!,
                  TokenizationSpecificationType.direct => {"protocolVersion": "ECv2", "publicKey": widget.publicKey},
                },
              },
            },
          ],
          "transactionInfo": {
            "currencyCode": widget.currencyCode ?? "USD",
            "countryCode": widget.currencyCode?.substring(0, 2) ?? "US",
            "totalPriceStatus": widget.transactionInfoStatus?.value ?? TransactionInfoStatus.statusFinal.value,
            "totalPrice": widget.totalPrice,
            "checkoutOption": widget.checkoutOption.value,
          },
          "merchantInfo": {"merchantId": widget.merchantId, "merchantName": widget.merchantName},
        },
      }),
    ),
  };

  // Initializes the Pay client with the configuration
  Pay get _pay => Pay(_configurations);

  // Default button height if user hasn't set one
  Size get _buttonSize => Size(210, 40);

  // Event channel to listen for payment results
  static const _eventChannel = EventChannel('plugins.flutter.io/pay/payment_result');

  /// This channel receives payment results from the native platform.
  StreamSubscription<Map<String, dynamic>>? _paymentResultSubscription;

  @override
  void dispose() {
    _paymentResultSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig
    SizeConfig.initialization(context);
    return Padding(
      // Applies external spacing to the button
      padding: widget.margin ?? ScaledEdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        // Handles tap event to start the Google Pay flow
        onTap: () async {
          try {
            // Cancels any previous payment result subscription
            _paymentResultSubscription?.cancel();

            _paymentResultSubscription = _eventChannel
                .receiveBroadcastStream()
                .map((result) => jsonDecode(result as String) as Map<String, dynamic>)
                .listen(
                  (result) {
                    // Calls the user-defined callback with the result
                    widget.onPaymentResult(result);
                  },
                  onError: (error) {
                    // Prints error in red if something goes wrong
                    debugPrint('\x1B[31m [Google Pay] Error: $error \x1B[0m');
                  },
                );
            // Shows the Google Pay sheet with the payment items
            await _pay.showPaymentSelector(PayProvider.google_pay, widget.paymentItems);
          } catch (e) {
            // Prints error in red if something goes wrong
            debugPrint('\x1B[31m [Google Pay] Error: $e \x1B[0m');
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
                  SvgPicture.memory(_googleLogoSvgBytes, height: 20.pr, width: 20.pr),
                  // Adds space between logo and text
                  Padding(
                    padding: ScaledEdgeInsets.only(left: 10),
                    child: Text(
                      'Pay with Google Pay',
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
