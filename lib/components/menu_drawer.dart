import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/session.dart';
import '../theme/theme_controller.dart';

class MenuDrawer extends StatelessWidget {
  final String currentRoute;

  const MenuDrawer({super.key, required this.currentRoute});

  void _navegar(BuildContext context, String rota) {
    Navigator.pop(context);
    if (rota == currentRoute) return;
    Navigator.pushReplacementNamed(context, rota);
  }

  Future<void> _sair(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.logout_rounded),
        title: const Text('Sair do aplicativo'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (confirmar == true && context.mounted) {
      Session.clear();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.primary, scheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: scheme.onPrimary,
                  child: Icon(Icons.school_rounded, size: 32, color: scheme.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  'Student Hub',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  Session.email ?? 'Visitante',
                  style: TextStyle(color: scheme.onPrimary.withValues(alpha: 0.85)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _item(context, Icons.home_rounded, 'Início', AppRoutes.home),
                _item(context, Icons.calculate_rounded, 'Calculadora', AppRoutes.calculadora),
                _item(context, Icons.person_add_alt_1_rounded, 'Cadastrar Aluno', AppRoutes.cadastro),
                _item(context, Icons.menu_book_rounded, 'Cursos', AppRoutes.cursos),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeController,
                  builder: (context, mode, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SwitchListTile(
                      secondary: Icon(
                        mode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      ),
                      title: const Text('Modo escuro'),
                      value: mode == ThemeMode.dark,
                      onChanged: (_) => toggleTheme(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.logout_rounded, color: scheme.error),
              title: Text('Sair', style: TextStyle(color: scheme.error, fontWeight: FontWeight.w600)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () => _sair(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icone, String titulo, String rota) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        leading: Icon(icone),
        title: Text(titulo),
        selected: rota == currentRoute,
        selectedColor: scheme.onPrimaryContainer,
        selectedTileColor: scheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () => _navegar(context, rota),
      ),
    );
  }
}
