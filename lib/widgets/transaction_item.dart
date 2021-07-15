import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text("${transaction.amount.toStringAsFixed(3)}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
        title: Text("${transaction.title}", style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text("${DateFormat('EEE - dd MMMM yyyy - HH:mm').format(transaction.date)}"),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}