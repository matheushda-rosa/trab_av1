import 'package:flutter_test/flutter_test.dart';

import 'package:trab_av1/main.dart';

void main() {
  testWidgets('App inicia na tela de login', (tester) async {
    await tester.pumpWidget(const StudentHubApp());
    await tester.pumpAndSettle();

    expect(find.text('Student Hub'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Login valida campos vazios', (tester) async {
    await tester.pumpWidget(const StudentHubApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe a senha'), findsOneWidget);
  });
}
