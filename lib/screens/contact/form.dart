import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      // App padding to the column
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // bind the controllers to the TextFields
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                ),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                // Adjust the "create button behavior"
                child: _CreateButton(
                  _nameController,
                  _accountNumberController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }
}

class _CreateButton extends StatelessWidget {
  final ContactDao _dao = ContactDao();

  _CreateButton(this.nameController, this.accountNumberController);

  final TextEditingController nameController;
  final TextEditingController accountNumberController;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Create'),
      onPressed: () async {
        final String name = nameController.text.trim();
        final int accountNumber = int.tryParse(accountNumberController.text);
        if (name != null && name.length > 0 && accountNumber != null) {
          final Contact newContact = Contact(0, name, accountNumber);
          await _dao.save(newContact);
          Navigator.pop(context);
        } else {
          final snackBar = SnackBar(
            content: Text('Ivalid Values'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
