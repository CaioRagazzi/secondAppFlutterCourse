import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function removeTransaction;

  TransactionList(this.userTransaction, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                children: <Widget>[
                  Text('No transactions added yet !'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                          child: Text('\$${userTransaction[index].amount}')),
                    ),
                  ),
                  title: Text(
                    '${userTransaction[index].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                      '${DateFormat.yMMMd().format(userTransaction[index].date)}'),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeTransaction(userTransaction[index].id);
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeTransaction(userTransaction[index].id);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: userTransaction.length,
            scrollDirection: Axis.vertical,
          );
  }
}
