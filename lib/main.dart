import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

// Change your application to start with the TransferForm
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferForm(),
    );
  }
}

// Create Transfer Form
class TransferForm extends StatelessWidget {
  // Create the controllers
  final TextEditingController _accountNumberFieldController =
      TextEditingController();
  final TextEditingController _valueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Transfer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              // put the controllers in the TextFields
              controller: _accountNumberFieldController,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: 'Account number',
                hintText: '0000',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _valueFieldController,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Value',
                hintText: '0.00',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          RaisedButton(
            child: Text('Confirm'),
            onPressed: () {
              // Parse the values!
              final int accountNumber =
                  int.tryParse(_accountNumberFieldController.text);
              final double value = double.tryParse(_valueFieldController.text);

              if (accountNumber != null && value != null) {
                // Create a transfer from the values
                final transferCreated = Transfer(value, accountNumber);
                // Print the transfer
                debugPrint('$transferCreated');
              } else {
                print('Invalid values...');
              }
            },
          )
        ],
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfers'),
      ),
      // Extract the transfer list widget
      body: Column(children: [
        // Use the transfer class
        TransferItem(Transfer(100.0, 1001)),
        TransferItem(Transfer(200.0, 2002)),
        TransferItem(Transfer(300.0, 3002)),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
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

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  // Implement toString
  // ALT+insert -> toString
  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}
