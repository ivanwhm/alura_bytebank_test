import 'package:alura_bytebank_tests/database/dao/contact_dao.dart';
import 'package:alura_bytebank_tests/http/web_clients/transaction_web_client.dart';
import 'package:flutter/widgets.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  final Widget child;

  AppDependencies({
    @required this.contactDao,
    @required this.transactionWebClient,
    @required this.child,
  })  : assert(contactDao != null),
        assert(child != null),
        super(child: child);

  static AppDependencies of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies old) {
    return old.contactDao != contactDao || old.transactionWebClient != transactionWebClient;
  }
}
