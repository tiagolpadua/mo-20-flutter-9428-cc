import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

// Change your application to start with the TransferForm
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferList(),
    );
  }
}

// 1 - Convert TransferForm to a statefull widget
class TransferForm extends StatefulWidget {
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberFieldController =
      TextEditingController();

  final TextEditingController _valueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Transfer'),

      ),

      // 2 - Wrap the column in a SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _accountNumberFieldController,
              label: 'Account Number',
              hint: '0000',
            ),
            // Change the constructor calling methot
            Editor(
              controller: _valueFieldController,
              label: 'Value',
              hint: '0.00',
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text('Confirm'),
              onPressed: () => _createTransfer(context),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    // Parse the values!
    final int accountNumber = int.tryParse(_accountNumberFieldController.text);
    final double value = double.tryParse(_valueFieldController.text);

    if (accountNumber != null && value != null) {
      final createdTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, createdTransfer);
    } else {
      print('Invalid values...');
    }
  }

  // 2 - Use the dispose lifecycle hook to dispose the controllers
  @override
  void dispose() {
    _accountNumberFieldController.dispose();
    _valueFieldController.dispose();
    super.dispose();
  }
}

class Editor extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final IconData icon;

  // Change the constructor to use named optional parameters
  const Editor({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// 1 - Create  the TransferList statefull widget - stful
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
        title: Text('Transfers'),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(),
            ),
          );

          future.then((transferReceived) {
            debugPrint('arrived at then of the future $transferReceived');

            // 1 - Check for null value from the future
            if (transferReceived != null) {
              debugPrint('$transferReceived');
              setState(() {
                widget._transfers.add(transferReceived);
              });
            }
          });
        },
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
