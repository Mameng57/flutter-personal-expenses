import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final Function scrollHandler;
  final ScrollController _scrollController = ScrollController();

  TransactionList({
    required this.transactions,
    required this.deleteTransaction,
    required this.scrollHandler
  });

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return transactions.isNotEmpty
    ? NotificationListener<ScrollEndNotification>(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return TransactionItem(
            transaction: transactions[index],
            deleteTransaction: deleteTransaction,
          );
        },
      ),
      onNotification: (_) {
        if(
          _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent
        ) {
          scrollHandler(false);
        }
        else {
          scrollHandler(true);
        }

        return true;
      },
    )
    : SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        children: [
          Image.asset('assets/images/zzz.png',
            width: _mediaQuery.size.width * 0.35,
            height: _mediaQuery.size.height * 0.15,
          ),
          const Divider(height: 50, color: Colors.transparent),
          const Text("Transaksi Kosong ...", style: const TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}