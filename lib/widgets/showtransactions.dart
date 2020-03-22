import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class ShowTransaction extends StatelessWidget {
  List<Transaction> transaction;
  Function deletetx;
  ShowTransaction(this.transaction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transaction.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          elevation: 6,
          child: Container(
            //height: 100,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                      child: Text(
                    "₹${transaction[index].amount.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.purple[700],
                    ),
                  )),
                ),
                radius: 30,
              ),
              title: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "${transaction[index].title.toUpperCase()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(
                "${DateFormat.yMMMd().add_jm().format(transaction[index].time)}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deletetx(index);
                  }),
            ),
          ),
        );
      },
    );
  }
}
