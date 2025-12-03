import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/controller/auth_provider.dart';
import 'package:remeal/widgets/drawer.dart';
import 'package:remeal/controller/favorite_controller.dart';
import '../controller/user_review_controller.dart';


class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String currentSection = "";

  void _logout() {
    Navigator.pop(context);
    ref.read(authControllerProvider.notifier).logout();
  }


  Widget _buildSection() {
    if (currentSection == "reviews") {
      final reviewState = ref.watch(userReviewControllerProvider);

      return reviewState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text("Erro ao carregar avaliações: $err")),
        data: (reviews) {
          if (reviews.isEmpty) {
            return const Center(child: Text("Nenhuma avaliação encontrada"));
          }

          // lista de reviews do controller
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ListTile(
                  leading: Image.network(
                    review.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(review.restaurantName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.comment,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < review.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(review.date,
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      );
    }

  // ---------- FAVORITOS ----------
  if (currentSection == "favorites") {
    final favState = ref.watch(favoriteControllerProvider);

    return favState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, st) => Center(
        child: Text("Erro: $err"),
      ),
      data: (favoriteIds) {
        if (favoriteIds.isEmpty) {
          return const Center(
            child: Text(
              "Nenhum restaurante favoritado ainda",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return FutureBuilder<List<dynamic>>(
          future: ref.read(favoriteControllerProvider.notifier).loadFavoriteRestaurants(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final favorites = snapshot.data!;

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final res = favorites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    leading: Image.network(
                      res['imagem'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      res['nome'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(res['categoria']),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await ref
                            .read(favoriteControllerProvider.notifier)
                            .toggleFavorite(res['id']);
                        setState(() {}); 
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }


  return const Center(
    child: Text("Selecione uma opção acima", style: TextStyle(fontSize: 16)),
  );
}


  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
        centerTitle: true,
      ),
      drawer: DrawerWidget(
        drawerItems: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ],
        user: user,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() => currentSection = "reviews");
                },
                child: const Text("Minhas Avaliações"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => currentSection = "favorites");
                },
                child: const Text("Restaurantes Favoritos"),
              ),
            ],
          ),

          const SizedBox(height: 16),


          Expanded(
            child: _buildSection(),
          ),
        ],
      ),
    );
  }
}
