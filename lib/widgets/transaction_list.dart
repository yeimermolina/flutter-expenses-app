import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text('No Transaction added yet!',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                    height: constrains.maxHeight * 0.6,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            _deleteTransaction(transactions[index].id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
