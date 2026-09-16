import 'package:flutter/material.dart';

import '../components/feature_card.dart';
import '../components/menu_drawer.dart';
import '../components/theme_toggle_button.dart';
import '../core/routes.dart';
import '../core/session.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      drawer: const MenuDrawer(currentRoute: AppRoutes.home),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.9, end: 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                builder: (context, valor, child) => Transform.scale(scale: valor, child: child),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [scheme.primary, scheme.tertiary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, ${Session.nomeUsuario}!',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: scheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bem-vindo ao Student Hub, seu espaço para calcular, cadastrar alunos e explorar cursos.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onPrimary.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: scheme.onPrimary.withValues(alpha: 0.2),
                        child: Icon(Icons.school_rounded, size: 40, color: scheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Funcionalidades',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              FeatureCard(
                indice: 0,
                icone: Icons.calculate_rounded,
                titulo: 'Calculadora',
                descricao: 'Faça operações básicas com números inteiros e decimais.',
                cor: Colors.orange,
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.calculadora),
              ),
              FeatureCard(
                indice: 1,
                icone: Icons.person_add_alt_1_rounded,
                titulo: 'Cadastrar Aluno',
                descricao: 'Preencha os dados do aluno e gere o JSON do cadastro.',
                cor: Colors.teal,
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.cadastro),
              ),
              FeatureCard(
                indice: 2,
                icone: Icons.menu_book_rounded,
                titulo: 'Cursos',
                descricao: 'Conheça os cursos disponíveis e veja seus detalhes.',
                cor: Colors.indigo,
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.cursos),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
