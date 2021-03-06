import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';
import '../models/contact.dart';
import '../widgets/app_dependencies.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _contactNameController = TextEditingController();
  final _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _contactNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: 'Account number',
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Create'),
                    onPressed: () => _createContact(dependencies.contactDao),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid(String contactName, int contactAccount) {
    return contactName != null && contactName.length > 0 && contactAccount != null && contactAccount > 0;
  }

  void _createContact(ContactDao contactDao) async {
    final contactName = _contactNameController.text;
    final contactAccount = int.tryParse(_accountController.text);
    final isValidForm = _isValid(contactName, contactAccount);

    if (isValidForm) {
      final contact = Contact(
        id: 0,
        name: contactName,
        accountNumber: contactAccount,
      );
      await contactDao.save(contact);
      Navigator.of(context).pop();
    }
  }
}
