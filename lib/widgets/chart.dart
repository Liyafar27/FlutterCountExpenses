import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransationValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
     

      return {         
          
          //  'day': (DateFormat.E().format(weekDay).substring(0, 2)=='Mo' ? 'Пон': (DateFormat.E().format(weekDay).substring(0, 1)=='Tu' ? 'Вт': (DateFormat.E().format(weekDay).substring(0, 1)=='We' ? 'Ср':(DateFormat.E().format(weekDay).substring(0, 1)=='Th' ? 'Чт':(DateFormat.E().format(weekDay).substring(0, 1)=='Fr' ? 'П':(DateFormat.E().format(weekDay).substring(0, 1)=='Sa' ? 'С':'В')))))) ,
       'day': DateFormat.E().format(weekDay).substring(0, 2),      
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransationValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  

  @override
  Widget build(BuildContext context) {
    print(groupedTransationValues);
    return Card(
      elevation: 16,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransationValues.map((data) {
            // return Text(data['day']+ ':' + data['amount'].toString(),);
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
                ),              
            );
          }).toList(),
        ),
      ),
    );
  }
}
