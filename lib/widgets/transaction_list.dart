import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
                onPressed: () => deleteTransaction(transactions[index].id),
              ),
            ),
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
          Divider(height: 50, color: Colors.transparent),
          Text("Transaksi Kosong ...", style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}