import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudentInfoApp());

    // Verify that student profile title is displayed.
    expect(find.text('CSS3344 Mobile App Dev - Lab 02'), findsOneWidget);
    expect(find.text('VINCENT LEE CHENG HONG'), findsOneWidget);
  });
}
