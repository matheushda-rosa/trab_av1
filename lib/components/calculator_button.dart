import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color? cor;
  final Color? corTexto;
  final IconData? icone;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.cor,
    this.corTexto,
    this.icone,
    this.flex = 1,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _pressionado = false;

  void _setPressionado(bool valor) {
    if (_pressionado != valor) setState(() => _pressionado = valor);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fundo = widget.cor ?? scheme.surfaceContainerHighest;
    final frente = widget.corTexto ?? scheme.onSurface;

    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Listener(
          onPointerDown: (_) => _setPressionado(true),
          onPointerUp: (_) => _setPressionado(false),
          onPointerCancel: (_) => _setPressionado(false),
          child: AnimatedScale(
            scale: _pressionado ? 0.92 : 1,
            duration: const Duration(milliseconds: 90),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: fundo,
                foregroundColor: frente,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
              child: widget.icone != null
                  ? Icon(widget.icone, size: 26, semanticLabel: widget.texto)
                  : Text(
                      widget.texto,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
