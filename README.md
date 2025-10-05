# 🍽️ ReMeal

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9.2-blue?style=for-the-badge&logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-SDK-00B4AB?style=for-the-badge&logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge" alt="Platforms">
</div>

<div align="center">
  <p><em>Descubra, avalie e compartilhe suas experiências gastronômicas favoritas!</em></p>
</div>

## 📖 Sobre o Projeto

O **ReMeal** é um aplicativo móvel desenvolvido em Flutter que conecta amantes da culinária aos melhores restaurantes da região. O app permite descobrir novos estabelecimentos, ler avaliações de outros usuários e compartilhar suas próprias experiências gastronômicas.

### ✨ Funcionalidades Principais

- 🏪 **Descoberta de Restaurantes**: Explore uma ampla variedade de estabelecimentos
- ⭐ **Sistema de Avaliações**: Visualize ratings e comentários de outros usuários
- 📱 **Interface Intuitiva**: Design moderno e navegação fluida
- 🔍 **Detalhes Completos**: Informações detalhadas sobre cada restaurante
- 👤 **Perfil do Usuário**: Gerencie suas avaliações e histórico
- 📍 **Localização**: Endereços e informações de contato dos restaurantes

## 📱 Screenshots

*Em breve: Capturas de tela das principais funcionalidades*

## 🏗️ Arquitetura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── models/                      # Modelos de dados
│   ├── restaurant_model.dart    # Modelo de restaurante
│   └── user_review.dart         # Modelo de avaliação
├── pages/                       # Telas do aplicativo
│   ├── restaurants_page.dart    # Lista de restaurantes
│   ├── restaurant_details_page.dart # Detalhes do restaurante
│   ├── profile_page.dart        # Perfil do usuário
│   └── about_page.dart          # Sobre o aplicativo
├── widgets/                     # Componentes reutilizáveis
│   ├── restaurant_card.dart     # Card de restaurante
│   └── drawer.dart              # Menu lateral
├── navigation/                  # Navegação
│   └── bottom_navigation.dart   # Navegação inferior
└── data/                       # Dados mockados
    ├── mock_data.json          # Dados dos restaurantes
    └── mock_data_user.json     # Dados das avaliações
```

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK (^3.9.2)
- Dart SDK
- IDE (VS Code, Android Studio ou IntelliJ)
- Emulador Android/iOS ou dispositivo físico

### Instalação

1. **Clone o repositório**
   ```bash
   git clone https://github.com/junio-ifpiads2025/ReMeal.git
   cd ReMeal/remeal
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**
   ```bash
   flutter run
   ```

### Comandos Úteis

```bash
# Verificar se o ambiente está configurado
flutter doctor

# Executar em modo release
flutter run --release

# Gerar APK para Android
flutter build apk

# Executar testes
flutter test
```

## 🛠️ Tecnologias Utilizadas

- **[Flutter](https://flutter.dev/)** - Framework de desenvolvimento multiplataforma
- **[Dart](https://dart.dev/)** - Linguagem de programação
- **Material Design** - Sistema de design da Google
- **JSON** - Armazenamento local de dados mockados

## 📊 Funcionalidades Detalhadas

### 🏪 Lista de Restaurantes
- Visualização em cards com imagem, nome, descrição e rating
- Carregamento otimizado de imagens com fallback
- Navegação para detalhes com animações suaves

### 🔍 Detalhes do Restaurante
- Imagens em alta resolidade com parallax
- Informações completas: localização, descrição, avaliações
- Sistema de rating com estrelas
- Botão para adicionar avaliação (em desenvolvimento)

### 👤 Perfil do Usuário
- Histórico de avaliações realizadas
- Cards organizados com informações das reviews
- Interface limpa e organizada

### ℹ️ Sobre o App
- Informações sobre o projeto
- Apresentação da equipe de desenvolvimento
- Links para perfis GitHub dos desenvolvedores

## 👥 Equipe de Desenvolvimento

<div align="center">
  <table>
    <tr>
      <td align="center">
        <a href="https://github.com/Junio-Alves">
          <img src="https://avatars.githubusercontent.com/u/127040133?v=4" width="100px;" alt="Francisco Junio"/><br>
          <sub><b>Francisco Junio</b></sub>
        </a><br>
        <sub>Developer</sub>
      </td>
      <td align="center">
        <a href="https://github.com/mfeeee">
          <img src="https://avatars.githubusercontent.com/u/40470600?v=4" width="100px;" alt="Maria Fernanda"/><br>
          <sub><b>Maria Fernanda</b></sub>
        </a><br>
        <sub>Developer</sub>
      </td>
      <td align="center">
        <a href="https://github.com/Ryan-auchi">
          <img src="https://avatars.githubusercontent.com/u/191165793?v=4" width="100px;" alt="Ryan"/><br>
          <sub><b>Ryan</b></sub>
        </a><br>
        <sub>Developer</sub>
      </td>
    </tr>
  </table>
</div>

## 🎯 Roadmap

- [ ] Sistema completo de avaliações
- [ ] Filtros por categoria de restaurante
- [ ] Sistema de favoritos
- [ ] Mapa interativo com localização dos restaurantes
- [ ] Notificações push
- [ ] Login e autenticação de usuários
- [ ] Integração com APIs de mapas
- [ ] Sistema de recompensas e gamificação

## 📝 Licença

Este projeto foi desenvolvido como parte de um trabalho acadêmico do IFPI - Campus Parnaíba.

## 🤝 Contribuindo

Contribuições são sempre bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

<div align="center">
  <p>Desenvolvido com ❤️ pela equipe ReMeal</p>
  <p>IFPI - Campus Parnaíba • 2025</p>
</div>
