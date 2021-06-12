import 'package:flutter/material.dart';

class TransactionAdd extends StatefulWidget {
  final Function handler;

  TransactionAdd({required this.handler});

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0)
      return;

    widget.handler(
      title: titleController.text,
      amount: enteredAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Pengeluaran",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
            ),
            Divider(color: Colors.transparent, height: 10,),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nominal",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text("Tambah Baru"),
            ),
          ],
        ),
      ),
    );
  }
}