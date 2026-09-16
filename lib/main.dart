import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'screens/cadastro_aluno_page.dart';
import 'screens/calculadora_page.dart';
import 'screens/cursos_page.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(const StudentHubApp());
}

class StudentHubApp extends StatelessWidget {
  const StudentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Student Hub',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          initialRoute: AppRoutes.login,
          routes: {
            AppRoutes.login: (_) => const LoginPage(),
            AppRoutes.home: (_) => const HomePage(),
            AppRoutes.calculadora: (_) => const CalculadoraPage(),
            AppRoutes.cadastro: (_) => const CadastroAlunoPage(),
            AppRoutes.cursos: (_) => const CursosPage(),
          },
        );
      },
    );
  }
}
