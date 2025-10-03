import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'FlavorFinds',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),

          const Text(
            'O FlavorFinds é o seu aplicativo ideal para descobrir e avaliar restaurantes. '
            'Explore uma ampla variedade de cozinhas, leia avaliações de outros entusiastas por comida '
            'e compartilhe suas próprias experiências gastronômicas. Nosso objetivo é conectar amantes da culinária '
            'e ajudá-los a encontrar sua próxima refeição favorita.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),

          const Text(
            'Conheça o time',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),

          const Text(
            'Francisco Junio',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Maria Fernanda',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Ryan',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
