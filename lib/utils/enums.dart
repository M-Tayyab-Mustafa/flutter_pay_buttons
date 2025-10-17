/* SPDX-License-Identifier: CECILL-2.1
 * Copyright (c) 2024 M-Tayyab-Mustafa
 * Licensed under the CeCILL-2.1 License
 * See the LICENSE file for details.
 */

// This file is part of the main `flutter_pay_buttons.dart` library.
// It defines enums used for configuring payment behavior and options.
part of '../flutter_pay_buttons.dart';

/// Defines how the checkout process should behave.
///
/// - [lazy] → The checkout flow begins but doesn’t immediately complete the purchase.
///   (Useful when you need to confirm or verify the order before finalizing payment.)
///
/// - [immediate] → The payment is completed as soon as the user authorizes it.
///   (Used for one-tap payments or quick checkout flows.)
enum CheckoutOption {
  lazy('DEFAULT'),
  immediate('COMPLETE_IMMEDIATE_PURCHASE');

  /// The raw string value that matches what the payment API expects.
  final String value;

  /// Const constructor to associate each enum value with its string representation.
  const CheckoutOption(this.value);
}

/// Defines the type of tokenization (how card/payment data is secured).
///
/// - [paymentGateway] → Uses a payment gateway (like Stripe, Braintree, etc.)
///   to generate and process secure tokens.
///
/// - [direct] → The app communicates directly with the payment processor
///   to handle sensitive payment data.
///
/// These are required fields for Google Pay and Apple Pay configuration.
enum TokenizationSpecificationType {
  paymentGateway('PAYMENT_GATEWAY'),
  direct('DIRECT');

  /// The raw string value expected by payment configuration JSON.
  final String value;

  const TokenizationSpecificationType(this.value);
}

/// Represents the status of a transaction during checkout.
///
/// - [statusFinal] → The payment amount is final and confirmed.
/// - [statusPending] → The payment is pending or may change (e.g., pre-authorizations).
///
/// Used in payment request JSON to define how the amount should be interpreted.
enum TransactionInfoStatus {
  statusFinal('FINAL'),
  statusPending('PENDING');

  /// The raw string value used in the payment API.
  final String value;

  const TransactionInfoStatus(this.value);
}
