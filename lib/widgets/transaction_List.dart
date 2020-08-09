import 'package:Personal_Expense_App/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> trans;
  final Function deleteTX;
  TransactionList(this.trans,this.deleteTX);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 380,
        child: trans.isEmpty
            ? Column(children: [
                Text('No Items added yet!'),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ])
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 10,
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                                child: Text(
                                    'Rs ' + trans[index].amount.toString())),
                          ),
                        ),
                        title: Text(
                          trans[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle:
                            Text(DateFormat.yMMMd().format(trans[index].date)),
                        trailing: IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.delete),
                          onPressed: (){
                             deleteTX(trans[index].id);
                          },
                        )),
                  );
                },
                itemCount: trans.length,
              ));
  }
}
