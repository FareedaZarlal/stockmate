import 'package:flutter_test/flutter_test.dart';
import 'package:stockmate/main.dart';

void main() {
  testWidgets('App shows StockMate title', (WidgetTester tester) async {
    await tester.pumpWidget(const StockMateApp());
    expect(find.text('StockMate'), findsOneWidget);
  });
}
