import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
    ? ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: ListTile(
            leading: CircleAvatar(
              radius: 35,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: FittedBox(
                  child: Text("${transactions[index].amount.toStringAsFixed(3)}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            title: Text("${transactions[index].title}", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${DateFormat('EEE - dd MMMM yyyy - HH:mm').format(transactions[index].date)}"),
          ),
        );
      },
    )
    : SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/zzz.png', width: 150, height: 150,),
          Divider(height: 50, color: Colors.transparent),
          Text("Transaksi Kosong ...", style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}