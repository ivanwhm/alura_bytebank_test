import 'package:alura_bytebank_tests/http/web_clients/transaction_web_client.dart';
import 'package:alura_bytebank_tests/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'database/dao/contact_dao.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(
    ByteBankApp(
      contactDao: ContactDao(),
      transactionWebClient: TransactionWebClient(),
    ),
  );
}

class ByteBankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  ByteBankApp({
    @required this.contactDao,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green[900],
        ),
        home: Dashboard(),
      ),
    );
  }
}
