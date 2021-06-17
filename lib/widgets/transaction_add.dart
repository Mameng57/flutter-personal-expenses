import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionAdd extends StatefulWidget {
  final Function handler;

  TransactionAdd({required this.handler});

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate = DateTime.now();

  void _submitData() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0)
      return;

    widget.handler(
      title: enteredTitle,
      amount: enteredAmount,
      date: _pickedDate,
    );
    Navigator.of(context).pop();
  }

  void _startDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((dateValue) {
      if(dateValue == null)
        return;
      else
        setState(() {
          _pickedDate = dateValue;
        });
    });
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
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Pengeluaran",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
            ),
            Divider(color: Colors.transparent, height: 10,),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nominal (Dalam Ribuan)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                children: [
                  Text("Tanggal: ${DateFormat.yMMMEd().format(_pickedDate)}"
                  ),
                  SizedBox(width: 15,),
                  TextButton(
                    child: Text("Pilih Tanggal", 
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _startDatePicker,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text("Tambah Baru"),
            ),
          ],
        ),
      ),
    );
  }
}