import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPercentage;

  ChartBar({
    required this.label,
    required this.spending,
    required this.spendingPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                child: Text("Rp.${spending.toStringAsFixed(0)}k")
              ),
            ),
            const Divider(height: 4, color: Colors.transparent,),
            Container(
              width: 10,
              height: constraints.maxHeight * 0.6,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1,),
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 4, color: Colors.transparent,),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: Text("$label")
            ),
          ],
        );
      }
    );
  }
}