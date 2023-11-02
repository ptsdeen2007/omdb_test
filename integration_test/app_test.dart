import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:omdb_test/features/movies/presentation/view/finder_screen.dart';
import 'package:omdb_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    expect(find.byType(FinderScreen), findsOneWidget);

    await tester.tap(find.byType(FinderScreen));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("search")), findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.enterText(find.byType(TextField), 'Ghost');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tile 0')));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("details_screen")),findsOneWidget);



  });
}