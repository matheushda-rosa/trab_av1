class Session {
  static String? email;

  static String get nomeUsuario {
    final e = email;
    if (e == null || !e.contains('@')) return 'estudante';
    return e.split('@').first;
  }

  static void clear() => email = null;
}
