import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/http.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferList extends StatefulWidget {
  @override
  _TransferListState createState() => _TransferListState();
}

// Adjust TransferList to show the transactions
class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    findAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if(transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return TransactionItem(transaction);
                    },
                  );
                } else {
                  // 2 - return CenteredMessage
                  return CenteredMessage(
                      'No transactions found',
                      icon: Icons.warning
                  );
                }
              }
              break;
          }
          return CenteredMessage('Unkown error');
        },
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  // Create the transfer propety
  final Transaction _transaction;

  TransactionItem(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transaction.value.toString()),
        subtitle: Text(_transaction.contact.accountNumber.toString()),
      ),
    );
  }
}
