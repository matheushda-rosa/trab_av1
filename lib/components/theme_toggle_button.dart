import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, mode, _) {
        final escuro = mode == ThemeMode.dark;
        return IconButton(
          tooltip: escuro ? 'Modo claro' : 'Modo escuro',
          onPressed: toggleTheme,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: Tween(begin: 0.75, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              escuro ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(escuro),
            ),
          ),
        );
      },
    );
  }
}
