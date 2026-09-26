import 'package:auto_sparkle/home-component/enums/payment_type_enum.dart';
import 'package:auto_sparkle/home-component/enums/transaction_type_enum.dart';

class WalletTransaction {
  final String reference;
  final String date;
  final String time;
  final String description;
  final double amount;
  final TransactionType type;
  final PaymentMethod method;

  const WalletTransaction({
    required this.reference,
    required this.date,
    required this.time,
    required this.description,
    required this.amount,
    required this.type,
    required this.method,
  });
}
