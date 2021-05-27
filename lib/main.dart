import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_add.dart';
import './widgets/transaction_list.dart';
import '../models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Quicksand',
        textTheme: TextTheme(headline6: TextStyle(fontFamily: 'Pacifico')),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Pacifico', fontSize: 22),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Sepatu', amount: 400.000, date: DateTime.now()),
    Transaction(id: 't2', title: 'Baju', amount: 250.000, date: DateTime.now()),
  ];

  void _addNewTransaction({required String title, required double amount}) {
    final newTx = Transaction(
      id: DateFormat('DDDD').format(DateTime.now()), 
      title: title,
      amount: amount,
      date: DateTime.now()
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TransactionAdd(handler: _addNewTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [
          IconButton(
            onPressed: () => _showAddNewTransaction(context), 
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text("CHART"),
            ),
          ),
          TransactionList(transactions: _userTransactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}