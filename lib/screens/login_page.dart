import 'package:flutter/material.dart';

import '../components/theme_toggle_button.dart';
import '../core/routes.dart';
import '../core/session.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _ocultarSenha = true;
  bool _carregando = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    Session.email = _emailController.text.trim();
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.tertiary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconTheme(
                    data: IconThemeData(color: scheme.onPrimary),
                    child: const ThemeToggleButton(),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, valor, child) => Opacity(
                      opacity: valor,
                      child: Transform.translate(offset: Offset(0, 40 * (1 - valor)), child: child),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: scheme.primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.school_rounded, size: 48, color: scheme.primary),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Student Hub',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Acesse sua conta para continuar',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                                ),
                                const SizedBox(height: 28),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.email],
                                  decoration: AppTheme.input(context, 'E-mail', Icons.email_outlined, hint: 'seu@email.com'),
                                  validator: Validators.email,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _senhaController,
                                  obscureText: _ocultarSenha,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _entrar(),
                                  decoration: AppTheme.input(
                                    context,
                                    'Senha',
                                    Icons.lock_outline_rounded,
                                    suffix: IconButton(
                                      tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                                      icon: Icon(_ocultarSenha ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                      onPressed: () => setState(() => _ocultarSenha = !_ocultarSenha),
                                    ),
                                  ),
                                  validator: Validators.senha,
                                ),
                                const SizedBox(height: 28),
                                ElevatedButton(
                                  onPressed: _carregando ? null : _entrar,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheme.primary,
                                    foregroundColor: scheme.onPrimary,
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: _carregando
                                        ? SizedBox(
                                            key: const ValueKey('loading'),
                                            height: 22,
                                            width: 22,
                                            child: CircularProgressIndicator(strokeWidth: 2.5, color: scheme.primary),
                                          )
                                        : const Text('Entrar', key: ValueKey('texto')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
