import 'package:alura_bytebank_tests/database/dao/contact_dao.dart';
import 'package:alura_bytebank_tests/http/web_clients/transaction_web_client.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao {}

class MockTransactionWebClient extends Mock implements TransactionWebClient {}
