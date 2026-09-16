# Student Hub

Aplicativo Flutter desenvolvido para a Atividade Avaliativa de Desenvolvimento Mobile.

## Entrega

- **Nome:** Matheus Henrique da Rosa
- **Turma:** ADS 2025
- **Repositório GitHub:** https://github.com/matheushda-rosa/trab_av1
- **Aplicação publicada:** https://matheushda-rosa.github.io/trab_av1/

## Funcionalidades

- Tela de login com validação de e-mail e senha
- Tela inicial com boas-vindas e cards de funcionalidades
- Calculadora com as quatro operações, limpar e tratamento de divisão por zero
- Cadastro de aluno com validações e geração de JSON
- Grid de cursos com imagens em assets e detalhes em BottomSheet
- Menu lateral (Drawer) com navegação via Navigator

### Extras

- Modo escuro
- Botão apagar na calculadora
- Números decimais
- Animações
- Confirmação ao sair
- Layout responsivo para web e mobile
- Copiar JSON gerado

## Estrutura

```
lib/
├── components/
│   ├── calculator_button.dart
│   ├── curso_card.dart
│   ├── curso_detalhes_sheet.dart
│   ├── feature_card.dart
│   ├── menu_drawer.dart
│   └── theme_toggle_button.dart
├── core/
│   ├── routes.dart
│   └── session.dart
├── data/
│   └── cursos_data.dart
├── models/
│   └── curso.dart
├── screens/
│   ├── cadastro_aluno_page.dart
│   ├── calculadora_page.dart
│   ├── cursos_page.dart
│   ├── home_page.dart
│   └── login_page.dart
├── theme/
│   ├── app_theme.dart
│   └── theme_controller.dart
├── utils/
│   └── validators.dart
└── main.dart
```

## Executar

```bash
flutter pub get
flutter run -d chrome
```

## Publicar no GitHub Pages

```bash
flutter build web --release --base-href "/trab_av1/"
```

Copie o conteúdo de `build/web/` para a pasta `docs/`, faça commit e push, e em
**Settings → Pages** selecione a branch `main` e a pasta `/docs`.
