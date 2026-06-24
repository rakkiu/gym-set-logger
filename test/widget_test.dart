import 'package:flutter_test/flutter_test.dart';
import 'package:gymsetlogger/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const GymLogApp());
    expect(find.text('GYMLOG'), findsOneWidget);
  });
}
