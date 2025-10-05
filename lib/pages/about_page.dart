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
            'ReMeal',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),

          const Text(
            'O ReMeal é o seu aplicativo ideal para descobrir e avaliar restaurantes. '
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

          // Francisco Junio
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/127040133?v=4',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.person, size: 50),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Francisco Junio',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                 Text(
                  'Github: @Junio-Alves ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Maria Fernanda
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/40470600?v=4',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.person, size: 50),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Maria Fernanda',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Github: @mfeeee ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Ryan
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/191165793?v=4',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.person, size: 50),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ryan',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Github: @Ryan-auchi ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
