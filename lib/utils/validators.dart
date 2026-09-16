class Validators {
  static String? obrigatorio(String? value, String campo) {
    if (value == null || value.trim().isEmpty) return '$campo é obrigatório';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o e-mail';
    if (!value.contains('@')) return 'O e-mail deve conter @';
    return null;
  }

  static String? senha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  static String? idade(String? value) {
    if (value == null || value.trim().isEmpty) return 'Idade é obrigatória';
    final idade = int.tryParse(value.trim());
    if (idade == null) return 'Informe uma idade numérica válida';
    if (idade < 1 || idade > 120) return 'Informe uma idade entre 1 e 120';
    return null;
  }
}
