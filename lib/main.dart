import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalspending/widgets/showtransactions.dart';
import './widgets/newtransactions.dart';
import './widgets/chart.dart';
import './models/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showchart = false;
  final List<Transaction> transaction = [];
  void _addtx(double amount, String title, DateTime date) {
    setState(() {
      transaction.add(Transaction(
        amount: amount,
        id: DateTime.now().toString(),
        time: date,
        title: title,
      ));
    });
  }

  void _deletetransaction(int index) {
    setState(() {
      transaction.removeAt(index);
    });
  }

  void popupsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(
            _addtx,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      backgroundColor: Colors.purple[400],
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: () => popupsheet(context))
      ],
      centerTitle: true,
      title: Text("PERSONAL EXPENSE"),
    );
    double availableheight(percent) {
      return (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          percent;
    }

    final txlist = transaction.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Data Found"),
              Container(
                child: Image.asset(
                  'assets/images/nodata.png',
                  fit: BoxFit.cover,
                ),
                height: availableheight(0.65),
              )
            ],
          )
        : Container(
            height: availableheight(islandscape?0.85:0.75),
            child: ShowTransaction(transaction, _deletetransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            if (islandscape)
              Container(
                height: availableheight(0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show Chart"),
                    Switch(
                        value: showchart,
                        onChanged: (val) {
                          setState(() {
                            showchart = val;
                          });
                        })
                  ],
                ),
              ),
            if (islandscape)
              showchart
                  ? Container(
                      height: availableheight(0.75),
                      child: Chart(transaction.where((item) {
                        return (item.time
                            .isAfter(DateTime.now().subtract(Duration(days: 7))));
                      }).toList()),
                    )
                  : txlist,
            if (!islandscape)
              Container(
                height: availableheight(0.25),
                child: Chart(transaction.where((item) {
                  return (item.time
                      .isAfter(DateTime.now().subtract(Duration(days: 7))));
                }).toList()),
              ),
            if (!islandscape) txlist
          ],
        ),
      ),
      floatingActionButtonLocation: (!islandscape)?FloatingActionButtonLocation.centerFloat : null ,
      floatingActionButton: (!islandscape) ? FloatingActionButton(
        onPressed: () => popupsheet(context),
        child: Icon(Icons.add),
      ):null,
      
    );
  }
}
