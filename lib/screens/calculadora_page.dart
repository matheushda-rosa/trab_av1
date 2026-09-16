import 'package:flutter/material.dart';

import '../components/calculator_button.dart';
import '../components/menu_drawer.dart';
import '../components/theme_toggle_button.dart';
import '../core/routes.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  static const _maxDigitos = 15;

  String _visor = '0';
  String _expressao = '';
  double? _primeiroValor;
  String? _operador;
  bool _novoNumero = true;
  bool _erro = false;

  void _resetar() {
    _visor = '0';
    _expressao = '';
    _primeiroValor = null;
    _operador = null;
    _novoNumero = true;
    _erro = false;
  }

  void _limpar() => setState(_resetar);

  void _digito(String digito) {
    setState(() {
      if (_erro) _resetar();
      if (_novoNumero) {
        _visor = digito;
        _novoNumero = false;
      } else if (_visor == '0') {
        _visor = digito;
      } else if (_visor.replaceAll('.', '').replaceAll('-', '').length < _maxDigitos) {
        _visor += digito;
      }
    });
  }

  void _decimal() {
    setState(() {
      if (_erro) _resetar();
      if (_novoNumero) {
        _visor = '0.';
        _novoNumero = false;
      } else if (!_visor.contains('.')) {
        _visor += '.';
      }
    });
  }

  void _apagar() {
    setState(() {
      if (_erro) {
        _resetar();
        return;
      }
      if (_novoNumero) return;
      final semSinal = _visor.startsWith('-') ? _visor.substring(1) : _visor;
      if (semSinal.length <= 1) {
        _visor = '0';
        _novoNumero = true;
      } else {
        _visor = _visor.substring(0, _visor.length - 1);
      }
    });
  }

  void _operacao(String op) {
    setState(() {
      if (_erro) return;
      final atual = _valorVisor();

      if (_operador != null && !_novoNumero && _primeiroValor != null) {
        final resultado = _calcular(_primeiroValor!, atual, _operador!);
        if (resultado == null) {
          _mostrarErro();
          return;
        }
        _primeiroValor = resultado;
        _visor = _formatar(resultado);
      } else if (_operador == null) {
        _primeiroValor = atual;
      }

      _operador = op;
      _expressao = '${_formatar(_primeiroValor!)} $op';
      _novoNumero = true;
    });
  }

  void _igual() {
    setState(() {
      if (_erro || _operador == null || _primeiroValor == null) return;
      final atual = _valorVisor();
      final resultado = _calcular(_primeiroValor!, atual, _operador!);
      if (resultado == null) {
        _mostrarErro();
        return;
      }
      _expressao = '${_formatar(_primeiroValor!)} $_operador ${_formatar(atual)} =';
      _visor = _formatar(resultado);
      _primeiroValor = null;
      _operador = null;
      _novoNumero = true;
    });
  }

  double _valorVisor() {
    final texto = _visor.endsWith('.') ? '${_visor}0' : _visor;
    return double.tryParse(texto) ?? 0;
  }

  double? _calcular(double a, double b, String op) {
    double? resultado;
    switch (op) {
      case '+':
        resultado = a + b;
        break;
      case '-':
        resultado = a - b;
        break;
      case '×':
        resultado = a * b;
        break;
      case '÷':
        resultado = b == 0 ? null : a / b;
        break;
    }
    if (resultado == null || !resultado.isFinite) return null;
    return resultado;
  }

  void _mostrarErro() {
    final divisaoPorZero = _operador == '÷';
    _visor = 'Erro';
    _expressao = divisaoPorZero ? 'Não é possível dividir por zero' : 'Resultado inválido';
    _primeiroValor = null;
    _operador = null;
    _novoNumero = true;
    _erro = true;
  }

  String _formatar(double valor) {
    if (valor.abs() >= 1e15) return valor.toStringAsExponential(6);
    if (valor == valor.truncateToDouble()) return valor.toInt().toString();
    var texto = valor.toStringAsFixed(8);
    texto = texto.replaceFirst(RegExp(r'0+$'), '');
    texto = texto.replaceFirst(RegExp(r'\.$'), '');
    return texto;
  }

  String _exibir(String texto) => texto.replaceAll('.', ',');

  Widget _linha(List<Widget> botoes) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: botoes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final corOperador = scheme.primaryContainer;
    final textoOperador = scheme.onPrimaryContainer;

    CalculatorButton numero(String n, {int flex = 1}) =>
        CalculatorButton(texto: n, flex: flex, onPressed: () => _digito(n));

    CalculatorButton operador(String op) => CalculatorButton(
          texto: op,
          cor: _operador == op && _novoNumero ? scheme.primary : corOperador,
          corTexto: _operador == op && _novoNumero ? scheme.onPrimary : textoOperador,
          onPressed: () => _operacao(op),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      drawer: const MenuDrawer(currentRoute: AppRoutes.calculadora),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _exibir(_expressao),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, color: _erro ? scheme.error : scheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8),
                          Flexible(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              layoutBuilder: (atual, anteriores) => Stack(
                                alignment: Alignment.centerRight,
                                children: [...anteriores, if (atual != null) atual],
                              ),
                              transitionBuilder: (child, animation) => FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  alignment: Alignment.centerRight,
                                  scale: Tween(begin: 0.92, end: 1.0).animate(animation),
                                  child: child,
                                ),
                              ),
                              child: FittedBox(
                                key: ValueKey('$_visor$_erro'),
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  _exibir(_visor),
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w300,
                                    color: _erro ? scheme.error : scheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _linha([
                          CalculatorButton(
                            texto: 'C',
                            flex: 2,
                            cor: scheme.errorContainer,
                            corTexto: scheme.onErrorContainer,
                            onPressed: _limpar,
                          ),
                          CalculatorButton(
                            texto: 'Apagar',
                            icone: Icons.backspace_outlined,
                            cor: scheme.secondaryContainer,
                            corTexto: scheme.onSecondaryContainer,
                            onPressed: _apagar,
                          ),
                          operador('÷'),
                        ]),
                        _linha([numero('7'), numero('8'), numero('9'), operador('×')]),
                        _linha([numero('4'), numero('5'), numero('6'), operador('-')]),
                        _linha([numero('1'), numero('2'), numero('3'), operador('+')]),
                        _linha([
                          numero('0', flex: 2),
                          CalculatorButton(texto: ',', onPressed: _decimal),
                          CalculatorButton(
                            texto: '=',
                            cor: scheme.primary,
                            corTexto: scheme.onPrimary,
                            onPressed: _igual,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
