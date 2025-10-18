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
/// A custom Google Pay button widget that integrates with the `pay` plugin.
/// It allows easy setup of Google Pay payment flow with UI customization options.
class GooglePayButton extends StatefulWidget {
  const GooglePayButton({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.backgroundColor,
    this.cornersRadius,
    this.isTesting = false,
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
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    required this.onPaymentResult,
    required this.paymentItems,
    required this.totalPrice,
    required this.merchantId,
    required this.merchantName,
  }) : // Validation: if using payment gateway, parameters must be provided
       assert(
         !(tokenizationSpecificationType ==
                 TokenizationSpecificationType.paymentGateway &&
             tokenizationSpecificationParameters == null),
         'Invalid tokenization specification: tokenizationSpecificationParameters are required when type is set to paymentGateway',
       ),
       // Validation: ensure the width is at least 220
       assert(
         !(width != null && width < 220),
         'Invalid width: width must be less than 220',
       );

  // ----------- UI CUSTOMIZATION PARAMETERS -----------

  /// Height of the Google Pay button.
  final double? height;

  /// Width of the Google Pay button.
  final double? width;

  /// External margin around the button.
  final ScaledEdgeInsets? margin;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Border radius for rounded corners.
  final double? cornersRadius;

  /// Optional custom child widget to replace the default design.
  final Widget? child;

  /// Main axis alignment for button content.
  final MainAxisAlignment mainAxisAlignment;

  /// Main axis size for button layout.
  final MainAxisSize mainAxisSize;

  // ----------- PAYMENT CONFIGURATION PARAMETERS -----------

  /// Whether to use the Google Pay test environment.
  final bool isTesting;

  /// List of payment items to be shown in the payment sheet.
  final List<PaymentItem> paymentItems;

  /// API version for Google Pay.
  final int? apiVersion;

  /// Minor version of the API.
  final int? apiVersionMinor;

  /// Allowed card networks (e.g., VISA, MASTERCARD).
  final List<String>? allowedCardNetworks;

  /// Whether billing address is required in the payment.
  final bool billingAddressRequired;

  /// Billing address format (e.g., "FULL" or "MINIMAL").
  final String? billingAddressFormat;

  /// Whether phone number is required for billing address.
  final bool phoneNumberRequired;

  /// Type of tokenization (e.g., direct or payment gateway).
  final TokenizationSpecificationType tokenizationSpecificationType;

  /// Parameters for tokenization (required for payment gateway type).
  final Map<String, dynamic>? tokenizationSpecificationParameters;

  /// Public key used for direct tokenization.
  final String? publicKey;

  /// Currency code (e.g., USD, EUR).
  final String? currencyCode;

  /// Status of transaction info (e.g., final or estimated).
  final TransactionInfoStatus? transactionInfoStatus;

  /// Total transaction price as a string.
  final String totalPrice;

  /// Checkout option type (immediate or lazy).
  final CheckoutOption checkoutOption;

  /// Merchant ID for Google Pay.
  final String merchantId;

  /// Merchant name displayed in Google Pay.
  final String merchantName;

  // ----------- CALLBACKS -----------

  /// Callback invoked when a payment result is received.
  final FutureOr<void> Function(Map<String, dynamic> result) onPaymentResult;

  @override
  State<GooglePayButton> createState() => _GooglePayButtonState();
}

/// Internal state for [GooglePayButton].
class _GooglePayButtonState extends State<GooglePayButton> {
  // Builds the Google Pay configuration JSON required by the `pay` plugin.
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
                "allowedCardNetworks":
                    widget.allowedCardNetworks ??
                    [
                      "MASTERCARD",
                      "VISA",
                      "AMEX",
                      "DISCOVER",
                      "INTERAC",
                      "JCB",
                    ],
                "assuranceDetailsRequired": true,
                "billingAddressRequired": widget.billingAddressRequired,
                "billingAddressParameters": {
                  "format": widget.billingAddressFormat ?? "FULL",
                  "phoneNumberRequired": widget.phoneNumberRequired,
                },
              },
              "tokenizationSpecification": {
                "type": widget.tokenizationSpecificationType.value,
                "parameters": switch (widget.tokenizationSpecificationType) {
                  TokenizationSpecificationType.paymentGateway =>
                    widget.tokenizationSpecificationParameters!,
                  TokenizationSpecificationType.direct => {
                    "protocolVersion": "ECv2",
                    "publicKey": widget.publicKey,
                  },
                },
              },
            },
          ],
          "transactionInfo": {
            "currencyCode": widget.currencyCode ?? "USD",
            "countryCode": widget.currencyCode?.substring(0, 2) ?? "US",
            "totalPriceStatus":
                widget.transactionInfoStatus?.value ??
                TransactionInfoStatus.statusFinal.value,
            "totalPrice": widget.totalPrice,
            "checkoutOption": widget.checkoutOption.value,
          },
          "merchantInfo": {
            "merchantId": widget.merchantId,
            "merchantName": widget.merchantName,
          },
        },
      }),
    ),
  };

  /// Initializes the Pay client with the Google Pay configuration.
  Pay get _pay => Pay(_configurations);

  /// Default fallback size for the button.
  Size get _buttonSize => Size(220, 40);

  /// Event channel for receiving payment results from native platform (Android/iOS).
  static const _eventChannel = EventChannel(
    'plugins.flutter.io/pay/payment_result',
  );

  /// Subscription to listen for payment results.
  StreamSubscription<Map<String, dynamic>>? _paymentResultSubscription;

  @override
  void dispose() {
    // Cancel any active subscriptions when widget is disposed.
    _paymentResultSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize responsive sizing configuration.
    SizeConfig.initialization(context);

    return Padding(
      // Adds margin (spacing) around the button.
      padding: widget.margin ?? ScaledEdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        // Detects taps on the button.
        onTap: () async {
          try {
            // Cancel previous event listener if active.
            _paymentResultSubscription?.cancel();

            // Start listening for payment result events.
            _paymentResultSubscription = _eventChannel
                .receiveBroadcastStream()
                .map(
                  (result) =>
                      jsonDecode(result as String) as Map<String, dynamic>,
                )
                .listen(
                  // Pass payment result to callback.
                  (result) => widget.onPaymentResult(result),
                  onError: (error) =>
                      debugPrint('\x1B[31m [Google Pay] Error: $error \x1B[0m'),
                );

            // Launch Google Pay payment sheet with provided payment items.
            await _pay.showPaymentSelector(
              PayProvider.google_pay,
              widget.paymentItems,
            );
          } catch (e) {
            // Handle and log any errors gracefully.
            debugPrint('\x1B[31m [Google Pay] Error: $e \x1B[0m');
          }
        },
        child:
            widget.child ??
            // Default Google Pay button UI.
            Container(
              height: widget.height?.pr ?? _buttonSize.height.pr,
              width: widget.width?.pr ?? _buttonSize.width.pr,
              padding: ScaledEdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.black,
                borderRadius: BorderRadius.circular(
                  widget.cornersRadius?.pr ?? 10.pr,
                ),
              ),
              child: Row(
                mainAxisSize: widget.mainAxisSize,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  // Display Google Pay logo (SVG).
                  SvgPicture.memory(
                    _googleLogoSvgBytes,
                    height: 22.pr,
                    width: 22.pr,
                  ),
                  // Space between logo and text.
                  Padding(
                    padding: ScaledEdgeInsets.only(left: 10),
                    child: Text(
                      'Pay with Google Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5.sp,
                        wordSpacing: 1.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
