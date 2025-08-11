part of 'flutter_pay_buttons.dart';

enum CheckoutOption {
  lazy('DEFAULT'),
  immediate('COMPLETE_IMMEDIATE_PURCHASE');

  final String value;
  const CheckoutOption(this.value);
}

enum TokenizationSpecificationType {
  paymentGateway('PAYMENT_GATEWAY'),
  direct('DIRECT');

  final String value;
  const TokenizationSpecificationType(this.value);
}

enum TransactionInfoStatus {
  statusFinal('FINAL'),
  statusPending('PENDING');

  final String value;
  const TransactionInfoStatus(this.value);
}
