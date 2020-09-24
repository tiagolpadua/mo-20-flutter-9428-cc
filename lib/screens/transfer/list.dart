import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/form.dart';
import 'package:flutter/material.dart';

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  _TransferListState createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
      ),
// 3 - Remove the floating action button
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () {
//          final Future future = Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => TransferForm(),
//            ),
//          );
//
//          future.then((transferReceived) {
//            debugPrint('arrived at then of the future $transferReceived');
//
//            if (transferReceived != null) {
//              debugPrint('$transferReceived');
//              setState(() {
//                widget._transfers.add(transferReceived);
//              });
//            }
//          });
//        },
//      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  // Create the transfer propety
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}