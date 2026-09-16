import 'package:flutter/material.dart';

import '../components/curso_card.dart';
import '../components/curso_detalhes_sheet.dart';
import '../components/menu_drawer.dart';
import '../components/theme_toggle_button.dart';
import '../core/routes.dart';
import '../data/cursos_data.dart';
import '../models/curso.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  void _abrirDetalhes(BuildContext context, Curso curso) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 640),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => CursoDetalhesSheet(curso: curso),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      drawer: const MenuDrawer(currentRoute: AppRoutes.cursos),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.78,
            ),
            itemCount: cursos.length,
            itemBuilder: (context, index) {
              final curso = cursos[index];
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Duration(milliseconds: 350 + index * 90),
                curve: Curves.easeOutCubic,
                builder: (context, valor, child) => Opacity(
                  opacity: valor,
                  child: Transform.scale(scale: 0.9 + 0.1 * valor, child: child),
                ),
                child: CursoCard(
                  curso: curso,
                  onTap: () => _abrirDetalhes(context, curso),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
