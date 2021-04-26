import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transactions,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin:  const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$ ${transactions.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          transactions.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('dd.MM.yyyy').format(transactions.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360 
        ? FlatButton.icon( 
          icon: Icon(Icons.delete),
          label: const Text('Удалить'),
          textColor:Theme.of(context).errorColor,
          onPressed: () => deleteTx(transactions.id), 
          )
           : IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => deleteTx(transactions.id),
            ),
       ),
      
    );
  }
  }