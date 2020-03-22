import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import '../widgets/buildbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttx;
  Chart(this.recenttx);
  List<Map<String, Object>> get weekchart {
    return List.generate(7, (index) {
      double amount = 0;
      DateTime date = DateTime.now().subtract(Duration(days: index));
      for (var i in recenttx) {
        if (i.time.day == date.day &&
            i.time.month == date.month &&
            i.time.year == date.year) {
          amount += i.amount;
        }
      }
      return {'day': DateFormat.E().format(date), 'amount': amount};
    }).reversed.toList();
  }

  double get totalamount {
    return weekchart.fold(0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekchart.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: BuildBar(
                amount: data['amount'],
                day: data['day'],
                percent: totalamount == 0
                    ? 0
                    : (data['amount'] as double) / totalamount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
