import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/menu_drawer.dart';
import '../components/theme_toggle_button.dart';
import '../core/routes.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';

class CadastroAlunoPage extends StatefulWidget {
  const CadastroAlunoPage({super.key});

  @override
  State<CadastroAlunoPage> createState() => _CadastroAlunoPageState();
}

class _CadastroAlunoPageState extends State<CadastroAlunoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _idadeController = TextEditingController();
  final _cursoController = TextEditingController();

  String? _json;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _idadeController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  void _salvar() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() => _json = null);
      return;
    }

    final Map<String, dynamic> aluno = {
      'nome': _nomeController.text.trim(),
      'email': _emailController.text.trim(),
      'idade': int.parse(_idadeController.text.trim()),
      'curso': _cursoController.text.trim(),
    };

    setState(() => _json = const JsonEncoder.withIndent('  ').convert(aluno));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Aluno cadastrado com sucesso!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _limpar() {
    _formKey.currentState!.reset();
    _nomeController.clear();
    _emailController.clear();
    _idadeController.clear();
    _cursoController.clear();
    setState(() => _json = null);
  }

  Future<void> _copiarJson() async {
    if (_json == null) return;
    await Clipboard.setData(ClipboardData(text: _json!));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('JSON copiado!'), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Aluno'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      drawer: const MenuDrawer(currentRoute: AppRoutes.cadastro),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.badge_rounded, color: scheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Dados do aluno',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _nomeController,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            decoration: AppTheme.input(context, 'Nome', Icons.person_outline_rounded),
                            validator: (v) => Validators.obrigatorio(v, 'Nome'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: AppTheme.input(context, 'E-mail', Icons.email_outlined),
                            validator: Validators.email,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _idadeController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: AppTheme.input(context, 'Idade', Icons.cake_outlined),
                            validator: Validators.idade,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _cursoController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _salvar(),
                            decoration: AppTheme.input(context, 'Curso', Icons.menu_book_outlined),
                            validator: (v) => Validators.obrigatorio(v, 'Curso'),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _limpar,
                                  icon: const Icon(Icons.cleaning_services_outlined),
                                  label: const Text('Limpar'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _salvar,
                                  icon: const Icon(Icons.save_rounded),
                                  label: const Text('Salvar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheme.primary,
                                    foregroundColor: scheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: _json == null
                      ? const SizedBox(width: double.infinity)
                      : Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: scheme.secondaryContainer,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.data_object_rounded, color: scheme.onSecondaryContainer),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'JSON gerado',
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: scheme.onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Copiar JSON',
                                        onPressed: _copiarJson,
                                        icon: Icon(Icons.copy_rounded, color: scheme.onSecondaryContainer),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: scheme.surface,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SelectableText(
                                      _json!,
                                      style: const TextStyle(fontFamily: 'monospace', fontSize: 15, height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
