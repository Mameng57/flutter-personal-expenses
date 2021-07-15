import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './local_storage.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_add.dart';
import './widgets/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  final LocalStorage storage = LocalStorage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    try {
      widget.storage.readFile().then((jsonString) {
        final data = jsonDecode(jsonString) as List;
        final List<Transaction> transactions = data.map(
          (element) => Transaction.fromJson(element)
        ).toList();

        setState(() {
          _userTransactions.addAll(transactions);
        });
      });
    }
    catch(_) {
      return;
    }
  }

  void _saveToLocalStorage(String data) {
    try {
      widget.storage.writeFile(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Berhasil di simpan!")),
      );
    }
    catch(_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Simpan gagal!")),
      );
    }
  }

  final List<Transaction> _userTransactions = [];
  bool _showChart = true;
  bool _showFloatingButton = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction({required String title, required double amount, required DateTime date}) {
    final newTx = Transaction(
      id: DateFormat('DDDD').format(date) + (DateTime.now().second.toString()),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TransactionAdd(handler: _addNewTransaction);
      }
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _scrollHandler(bool condition) {
    setState(() {
      _showFloatingButton = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar myAppBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () => _saveToLocalStorage(jsonEncode(_userTransactions)), 
        ),
        IconButton(
          onPressed: () => _showAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: myAppBar,
      body: Column(
        children: [
          if(_userTransactions.isNotEmpty) (
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Chart"),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  }
                ),
              ],
            )
          ),
          if(_showChart) (
            SizedBox(
              height: (
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                myAppBar.preferredSize.height
              ) * 0.25,
              child: Chart(_recentTransactions)
            )
          ),
          Expanded(
            child: TransactionList(
              transactions: _userTransactions,
              deleteTransaction: _deleteTransaction,
              scrollHandler: _scrollHandler,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _showFloatingButton,
        child: FloatingActionButton(
          onPressed: () => _showAddNewTransaction(context),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}