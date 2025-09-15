# NutriApp - Receitas & Nutrição

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Um aplicativo Flutter completo e inteligente para receitas e nutrição, com recursos inovadores que vão além dos apps convencionais.

## ✨ Funcionalidades Principais

### 🏠 **Tela Inicial Personalizada**
- **Saudação personalizada** com estatísticas do usuário
- **Sugestões de IA** baseadas nas metas calóricas
- **Receitas em destaque** em carrossel
- **Categorias interativas** (Vegetariano, Proteína, Rápido, Saudável)
- **Dicas de nutrição** diárias

### 🔍 **Busca Inteligente de Receitas**
- **Busca por voz** - fale para encontrar receitas
- **Filtros avançados** por categoria, dieta e restrições
- **Busca em tempo real** com resultados instantâneos
- **Interface intuitiva** com chips de filtro

### 📖 **Detalhes das Receitas**
- **Imagens em alta resolução** com efeito parallax
- **Lista completa de ingredientes** com quantidades
- **Instruções passo-a-passo** numeradas
- **Informações nutricionais detalhadas**
- **Função de favoritos** e **lista de compras integrada**

### 🧮 **Calculadora Nutricional**
- **Análise de refeições** em tempo real
- **Cálculo de IMC e TMB** automático
- **Adição de ingredientes** personalizada
- **Rastreamento nutricional** completo

### 👤 **Perfil do Usuário**
- **Informações pessoais** editáveis
- **Estatísticas de saúde** (IMC, TMB, categoria de peso)
- **Metas calóricas personalizáveis**
- **Preferências alimentares** (vegetariano, vegano, etc.)
- **Persistência de dados** local

## 🚀 **Funcionalidades Inovadoras**

### 🗣️ **Busca por Voz**
- Integração com `speech_to_text`
- Reconhecimento de fala em português
- Busca hands-free para conveniência

### 🤖 **Sugestões de IA**
- Algoritmo inteligente que sugere receitas baseadas em:
  - Metas calóricas diárias
  - Preferências alimentares
  - Restrições dietéticas

### 🛒 **Lista de Compras Integrada**
- Adicione ingredientes diretamente das receitas
- Interface simples e intuitiva
- Preparação otimizada para compras

### 📊 **Acompanhamento Nutricional**
- Cálculos automáticos de IMC e TMB
- Categorias de peso em português
- Metas personalizáveis

## 🛠️ **Tecnologias Utilizadas**

- **Flutter** - Framework para desenvolvimento multiplataforma
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **SharedPreferences** - Persistência local de dados
- **CachedNetworkImage** - Cache de imagens
- **Speech-to-Text** - Reconhecimento de voz
- **Material Design** - Design system do Google

## 📁 **Estrutura do Projeto**

```
lib/
├── models/           # Modelos de dados
│   ├── recipe.dart
│   ├── ingredient.dart
│   ├── nutrition_info.dart
│   ├── user.dart
│   └── models.dart
├── screens/          # Telas do aplicativo
│   ├── home_screen.dart
│   ├── recipe_list_screen.dart
│   ├── recipe_detail_screen.dart
│   ├── nutrition_calculator_screen.dart
│   └── profile_screen.dart
├── services/         # Lógica de negócio
│   ├── recipe_service.dart
│   └── user_service.dart
├── utils/            # Utilitários
│   └── theme.dart
└── main.dart         # Ponto de entrada
```

## 🚀 **Como Executar**

### Pré-requisitos
- Flutter SDK (versão 3.8.1 ou superior)
- Dart SDK (versão 3.0.0 ou superior)
- Android Studio ou VS Code com extensões Flutter

### Instalação

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/nutriapp.git
   cd nutriapp
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

### Para desenvolvimento

- **Análise de código:** `flutter analyze`
- **Testes:** `flutter test`
- **Formatação:** `flutter format .`

## 📱 **Capturas de Tela**

*(Adicione capturas de tela do aplicativo aqui)*

## 🎯 **Objetivos do Projeto**

Este projeto foi desenvolvido para demonstrar:

- **Arquitetura limpa** em Flutter
- **Integração de APIs nativas** (voz, câmera)
- **Gerenciamento de estado** avançado
- **Design responsivo** e acessível
- **Experiência do usuário** excepcional
- **Funcionalidades inovadoras** que diferenciam do mercado

## 🤝 **Contribuição**

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer um fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abrir um Pull Request

## 📝 **Licença**

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🙏 **Agradecimentos**

- Flutter Community
- Unsplash (para imagens de exemplo)
- Google Material Design
- Todos os contribuidores open source

---

⭐ **Dê uma estrela se este projeto te ajudou!**

Feito com ❤️ usando Flutter
