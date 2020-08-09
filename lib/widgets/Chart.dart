import 'package:Personal_Expense_App/models/transaction.dart';
import 'package:Personal_Expense_App/widgets/Chart_bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart(this.recentTrans);
  List<Map<String,Object>> get groupedTransaction
  {
    return List.generate(7, (index) {
      final weekDay= DateTime.now().subtract(Duration(days:index));
      int totalSum=0;
      for(var i=0; i < recentTrans.length;i++){
if(recentTrans[i].date.day== weekDay.day && recentTrans[i].date.month == weekDay.month && recentTrans[i].date.year==weekDay.year){
totalSum += recentTrans[i].amount ; 
}
      }
      return {'DAY': DateFormat.E().format(weekDay),'amount': totalSum};
    }).reversed.toList();
  }
  double get maxSpending{
    return groupedTransaction.fold(0,(sum,items){
      return sum+items['amount'];

    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: 
          groupedTransaction.map((data) {
            return Flexible( fit: FlexFit.tight ,
              child: ChartBar(data['DAY'], data['amount'], maxSpending == 0 ? 0: (data['amount'] as int) / maxSpending));
          }).toList(),
      ),
    );
  }
}
