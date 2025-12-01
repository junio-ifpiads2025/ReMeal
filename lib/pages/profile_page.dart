import 'dart:convert';
import 'about_page.dart';
import 'package:remeal/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/controller/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  List<UserReview> reviews = [];
  bool isLoading = true;

  void _logout() {
    Navigator.pop(context); // Fecha o drawer
    ref.read(authControllerProvider.notifier).logout();
    // O AuthChecker vai redirecionar automaticamente para o Login
  }

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      final String jsonString =
          await rootBundle.loadString('lib/data/mock_data_user.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      setState(() {
        reviews = jsonData
            .map((json) => UserReview.fromJson(json))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar as avaliações: $e');
    }
  }

  List<Widget> _drawerItems() {
    return [
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
        onTap: () => _logout(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Reviews"),
        centerTitle: true,
      ),
      drawer: DrawerWidget(drawerItems: _drawerItems(), user: user),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reviews.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhuma avaliação encontrada',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: ListTile(
                        leading: Image.network(
                          review.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          review.restaurantName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.comment,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < review.rating.round()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  review.date,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }
}
