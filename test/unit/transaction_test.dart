import 'package:alura_bytebank_tests/models/contact.dart';
import 'package:alura_bytebank_tests/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the transaction value when create a transaction.', () {
    final transaction = Transaction(id: null, value: 200.0, contact: Contact(id: 0, name: 'Ivan', accountNumber: 1));

    expect(transaction.value, equals(200.0));
  });

  test('Should show an error when create a transaction with a negative value.', () {
    expect(
        () => Transaction(
              id: null,
              value: -15.0,
              contact: Contact(id: 0, name: 'Ivan', accountNumber: 1),
            ),
        throwsAssertionError);
  });
}
