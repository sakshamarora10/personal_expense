import 'package:flutter/material.dart';

class BuildBar extends StatelessWidget {
  final double amount;
  final String day;
  final double percent;
  BuildBar({this.day, this.amount, this.percent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.125,
            child: FittedBox(
              child: Text(
                "₹${amount.toStringAsFixed(0)}",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
              height: constraints.maxHeight * 0.75,
              width: constraints.maxWidth * 0.4,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                ),
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[400],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      )),
                ),
              )),
          Container(
            height: constraints.maxHeight * 0.125,
            child: Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    });
  }
}
