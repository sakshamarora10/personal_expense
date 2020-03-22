import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  Function newtx;
  NewTransaction(this.newtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController title=TextEditingController();
  final TextEditingController amount=TextEditingController();
  DateTime date;

  void submitdata(){
    if(title.text.isNotEmpty&&double.parse(amount.text)>0&&date!=null){
      widget.newtx(double.parse(amount.text),title.text,date);
      Navigator.of(context).pop();
    }
  }
  void _showdatepicker(){
    showDatePicker(
      context: context, 
      initialDate:DateTime.now(), 
      firstDate:DateTime(2020), 
      lastDate:DateTime.now()).then((pickeddate){
        if(pickeddate==null)return;
        setState(() {
          date=pickeddate;
        });
      }
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom+5,
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget> [
            TextField(
              controller: title ,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color:Colors.purple[200],
                ),
                labelText: 'Title',
              ),
              onSubmitted: (_)=>submitdata(),
            ),
             TextField(
              controller: amount ,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color:Colors.purple[200],
                )
              ),
              onSubmitted: (_)=>submitdata(),
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.calendar_today),
                  onPressed: _showdatepicker,
                ),
                Text(date==null?"No Date Chosen":"${DateFormat.yMd().format(date)}",style: TextStyle(color: Colors.grey[800]),),],
            ),
            RaisedButton(
              color: Colors.purple[400],
              textColor: Colors.white,
              child: Text(
                "Submit",
                style:TextStyle(
                  fontSize: 15,
                ) ,),
              onPressed:(){
                submitdata();
              }
            ),
          ]
        )
        
      ),
    );
  }
}