import 'package:flutter/material.dart';

import '../models/curso.dart';

class CursoDetalhesSheet extends StatelessWidget {
  final Curso curso;

  const CursoDetalhesSheet({super.key, required this.curso});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(curso.imagem, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              curso.nome,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.schedule_rounded, size: 18),
                  label: Text('Duração: ${curso.duracao}'),
                ),
                Chip(
                  avatar: const Icon(Icons.category_rounded, size: 18),
                  label: Text(curso.categoria),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Sobre o curso',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              curso.descricao,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_rounded),
                label: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
