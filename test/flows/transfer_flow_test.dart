import 'package:alura_bytebank_tests/components/response_dialog.dart';
import 'package:alura_bytebank_tests/components/transaction_auth_dialog.dart';
import 'package:alura_bytebank_tests/database/dao/contact_dao.dart';
import 'package:alura_bytebank_tests/http/web_clients/transaction_web_client.dart';
import 'package:alura_bytebank_tests/main.dart';
import 'package:alura_bytebank_tests/models/contact.dart';
import 'package:alura_bytebank_tests/models/transaction.dart';
import 'package:alura_bytebank_tests/screens/contacts_list.dart';
import 'package:alura_bytebank_tests/screens/dashboard.dart';
import 'package:alura_bytebank_tests/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  ContactDao mockContactDao;
  TransactionWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockTransactionWebClient();
  });

  testWidgets('Should transfer to a contact', (tester) async {
    final ivanW = Contact(id: 0, name: "Ivan W.", accountNumber: 1);
    final transfer = Transaction(id: "", value: 200, contact: ivanW);

    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    when(mockContactDao.findAll()).thenAnswer((realInvocation) async => [ivanW]);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactLists = find.byType(ContactsList);
    expect(contactLists, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == "Ivan W." && widget.contact.accountNumber == 1;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Ivan W.');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text("1");
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) => textFieldByLabelTextMatcher(widget, "Value"));
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, "200");

    final transferButton = find.widgetWithText(ElevatedButton, "Transfer");
    expect(transferButton, findsOneWidget);

    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword = find.byKey(transactionAuthDialogTextFieldPassword);
    expect(textFieldPassword, findsOneWidget);

    await tester.enterText(textFieldPassword, "1000");

    final cancelButton = find.widgetWithText(TextButton, "Cancel");
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, "Cancel");
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save(transfer, "1000")).thenAnswer((_) async => transfer);

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, "OK");
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactListsBack = find.byType(ContactsList);
    expect(contactListsBack, findsOneWidget);
  });
}
