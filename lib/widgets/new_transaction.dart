import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = int.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate== null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((date) {
          if(date== null)
          {
            return;
          }
          setState(() {
            selectedDate= date;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Title',
          ),
          cursorColor: Colors.red,
          controller: titleController,
          onSubmitted: (_) {
            submitData();
          },
        ),
        TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            cursorColor: Colors.red,
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) {
              submitData();
            }),
        Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Expanded(child: Text(selectedDate == null ? 'No Date Choosen!' : 'Picked date: '+ DateFormat.yMMMd().format(selectedDate))),
              FlatButton(
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: presentDatePicker,
              )
            ],
          ),
        ),
        RaisedButton(
          child: Text('Add Transaction'),
          onPressed: () {
            submitData();
          },
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ]),
    );
  }
}
