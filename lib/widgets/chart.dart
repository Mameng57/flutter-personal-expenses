import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for(int i = 0; i < recentTransaction.length; i++) {
        if(
          recentTransaction[i].date.day == weekDay.day &&
          recentTransaction[i].date.month == weekDay.month &&
          recentTransaction[i].date.year == weekDay.year
        ) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day' : DateFormat.E().format(weekDay).substring(0, 1),
        'amount' : totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
      0.0, (sum, item) => sum += (item['amount'] as double)
    );
  }

  Chart(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    return recentTransaction.isNotEmpty
    ? Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'].toString(), 
                spending: (data['amount'] as double),
                spendingPercentage: (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    )
    : const SizedBox();
  }
}