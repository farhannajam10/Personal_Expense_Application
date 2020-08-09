import 'package:Personal_Expense_App/widgets/new_transaction.dart';
import 'package:Personal_Expense_App/widgets/transaction_List.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/Chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'QuickSand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(headline6:
               TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    button: TextStyle(color: Colors.white)),
          ),),
      title: 'Flutter App',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Transaction> trans = [
   // Transaction(
    //  id: 't1',
      //title: 'New shirt',
      //amount: 300,
      //date: DateTime.now(),
    //),
    //Transaction(
     // id: 't2',
     // title: 'New shoes',
      //amount: 500,
      //date: DateTime.now(),
    // ),
  ];
  List<Transaction> get recentTrans{
return trans.where((tx) {
  return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
}).toList();
 
}
  
  void addTransactions(String title, int amount, DateTime chosenDate ) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        id: DateTime.now().toString(),
        date: chosenDate);
    setState(() {
      trans.add(newTx);
    });
  }

  void addnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
void deleteTransaction(String id){
setState(() {
  trans.removeWhere((tx) {
    return tx.id == id;
  });
});
}
  @override
  Widget build(BuildContext context) {
    final appBar= AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Personal Expenses',
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addnewTransaction(context);
              }),
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Container( height: (MediaQuery.of(context).size.height- appBar.preferredSize.height- MediaQuery.of(context).padding.top) * 0.3,
                  child: Chart(recentTrans)),
              Container(height: (MediaQuery.of(context).size.height- appBar.preferredSize.height- MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(trans,deleteTransaction))
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addnewTransaction(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
