import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null ) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 25,
        child: Container(
          padding: EdgeInsets.only(top:10, left:10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10, ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[ 
              TextField(
                cursorColor: Colors.purple,
                cursorWidth: 6,
                decoration: InputDecoration(
                  labelText: 'Что купила',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
                // onChanged: (val) => titleInput = val,
              ),
              TextField(
                cursorColor: Colors.lime,
                cursorWidth: 6,
                decoration: InputDecoration(
                  labelText: 'Сколько стоило',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
                //onChanged: (val) {
                //amountInput = val;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(_selectedDate == null?
                        'Не выбрана дата!' : 'Дата:  ${DateFormat('dd.MM.yyyy').format(_selectedDate)}' ,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    AdaptiveFlarButton( _presentDatePicker, 'Выбрать дату')
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.lime, width: 3, style: BorderStyle.solid),
                ),
                child: FlatButton(
                  child: Text(
                    'Добавить покупку',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _submitData,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
