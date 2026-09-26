import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_sparkle/common/extensions.dart';
import 'package:auto_sparkle/home-component/enums/payment_type_enum.dart';
import 'package:auto_sparkle/home-component/enums/transaction_type_enum.dart';
import 'package:auto_sparkle/home-component/models/wallet_transaction_model.dart';

class WalletTransactionWidget extends StatelessWidget {
  final WalletTransaction transaction;

  const WalletTransactionWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ImageIcon(
                ResizeImage(
                  AssetImage('assets/images/${transaction.method.icon}.png'),
                  width: 70,
                  height: 70,
                  allowUpscaling: false,
                ),
                size: 40,
                color: transaction.type.equals(TransactionType.debit)
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        transaction.description,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(transaction.date),
                      const SizedBox(width: 12),
                      Text(transaction.time),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(locale: 'en_za')
                            .format(transaction.amount),
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              TextStyle(
                                  color: transaction.type
                                          .equals(TransactionType.debit)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
