import 'package:alura_bytebank_tests/http/web_clients/transaction_web_client.dart';
import 'package:alura_bytebank_tests/main.dart';
import 'package:alura_bytebank_tests/models/contact.dart';
import 'package:alura_bytebank_tests/screens/contact_form.dart';
import 'package:alura_bytebank_tests/screens/contacts_list.dart';
import 'package:alura_bytebank_tests/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  MockContactDao mockContactDao;
  TransactionWebClient transactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    transactionWebClient = MockTransactionWebClient();
  });

  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: transactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactLists = find.byType(ContactsList);
    expect(contactLists, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final addContact = find.widgetWithIcon(IconButton, Icons.add);
    expect(addContact, findsOneWidget);

    await tester.tap(addContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) => textFieldByLabelTextMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, "Ivan W.");

    final accountNumberTextField =
        find.byWidgetPredicate((widget) => textFieldByLabelTextMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, "1");

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(id: 0, name: "Ivan W.", accountNumber: 1))).called(1);

    final contactListsAfterAdd = find.byType(ContactsList);
    expect(contactListsAfterAdd, findsOneWidget);
  });
}
