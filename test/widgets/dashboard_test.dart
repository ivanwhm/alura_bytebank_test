import 'package:alura_bytebank_tests/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  MockContactDao mockContactDao;

  setUp(() async {
    mockContactDao = MockContactDao();
  });
  testWidgets('Should display the main image when the Dashboard is opened.', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);

    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is opened.', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);

    expect(iconTransferFeatureItem, findsOneWidget);

    final nameTransferFeatureItem = find.widgetWithText(FeatureItem, 'Transfers');
    expect(nameTransferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is opened (with predicate).', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final transferFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, 'Transfers', Icons.monetization_on),
    );

    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transaction feed feature when the Dashboard is opened.', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final transactionFeedFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, 'Transaction Feed', Icons.description),
    );

    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}
