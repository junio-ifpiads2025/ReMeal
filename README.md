# 🍽️ ReMeal --- Aplicativo de Avaliações Gastronômicas

<div align="center"> <img src="https://img.shields.io/badge/Flutter-3.9.2-blue?style=for-the-badge&logo=flutter" /> <img src="https://img.shields.io/badge/Dart-SDK-00B4AB?style=for-the-badge&logo=dart" /> <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge" /> </div> <div align="center"> <p><em>Descubra, avalie e compartilhe suas experiências gastronômicas favoritas!</em></p> </div>

------------------------------------------------------------------------

## 📖 Sobre o Projeto

O **ReMeal** é um aplicativo mobile desenvolvido em Flutter cujo
objetivo é permitir que usuários descubram restaurantes, avaliem suas
experiências e organizem suas preferências.

Nesta segunda etapa, o foco foi **implementar toda a lógica de
negócio**, **gerenciamento de estado com Riverpod**, e **persistência de
dados com SharedPreferences** --- incluindo sessão do usuário, tema,
favoritos, filtros e avaliações.

------------------------------------------------------------------------

## 🧠 Gerenciamento de Estado -- Riverpod

-   Atualização em tempo real de avaliações\
-   Estado global do usuário\
-   Sincronização do estado de favoritos e histórico

------------------------------------------------------------------------

## 🔐 Autenticação & Sessão -- SharedPreferences

-   Login e Cadastro funcionais\
-   Persistência de sessão\
-   Logout limpando dados salvos

------------------------------------------------------------------------

## ⚙️ Preferências & Configurações

-   Tema (Dark Mode) persistido\
-   Filtros salvos\
-   Dados simples armazenados no SharedPreferences

------------------------------------------------------------------------

## 📦 Persistência de Dados Complexos

-   Favoritos em JSON persistido\
-   Avaliações do usuário armazenadas localmente\
-   Histórico de avaliações

------------------------------------------------------------------------

## ⚠️ Tratamento de Erros

-   Snackbars para falhas\
-   Alertas de exceções

------------------------------------------------------------------------

## 🏗️ Arquitetura

    lib/
    ├── main.dart
    ├── models/
    ├── controllers/
    ├── services/
    ├── pages/
    ├── widgets/
    └── data/

------------------------------------------------------------------------

## 📱 Screenshots 

<p float="left"> <img src="https://github.com/junio-ifpiads2025/ReMeal/blob/main/images/1.jpeg" width="400" /> <img src="https://github.com/junio-ifpiads2025/ReMeal/blob/main/images/2.jpeg" width="400" /> </p> <p float="left"> <img src="https://github.com/junio-ifpiads2025/ReMeal/blob/main/images/3.jpeg" width="400" /> <img src="https://github.com/junio-ifpiads2025/ReMeal/blob/main/images/4.jpeg" width="400" /> </p>

------------------------------------------------------------------------

## 🚀 Como Executar

``` bash
git clone https://github.com/junio-ifpiads2025/ReMeal.git
cd ReMeal/remeal
flutter pub get
flutter run
```

------------------------------------------------------------------------

## 👥 Equipe de Desenvolvimento 
<div align="center"> <table> <tr> <td align="center"> <a href="https://github.com/Junio-Alves"> <img src="https://avatars.githubusercontent.com/u/127040133?v=4" width="100px;" alt="Francisco Junio"/><br> <sub><b>Francisco Junio</b></sub> </a><br> <sub>Developer</sub> </td> <td align="center"> <a href="https://github.com/mfeeee"> <img src="https://avatars.githubusercontent.com/u/40470600?v=4" width="100px;" alt="Maria Fernanda"/><br> <sub><b>Maria Fernanda</b></sub> </a><br> <sub>Developer</sub> </td> <td align="center"> <a href="https://github.com/Ryan-auchi"> <img src="https://avatars.githubusercontent.com/u/191165793?v=4" width="100px;" alt="Ryan"/><br> <sub><b>Ryan</b></sub> </a><br> <sub>Developer</sub> </td> </tr> </table> </div> 

------------------------------------------------------------------------

## 📝 Licença 

Este projeto foi desenvolvido como parte de um trabalho acadêmico do IFPI - Campus Parnaíba.
