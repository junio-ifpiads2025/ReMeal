import 'dart:convert';
import 'package:remeal/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/restaurant_model.dart';
import '../widgets/restaurant_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/controller/auth_provider.dart';

class RestaurantsPages extends ConsumerStatefulWidget {
  const RestaurantsPages({super.key});

  @override
  ConsumerState<RestaurantsPages> createState() => _RestaurantsPagesState();
}

class _RestaurantsPagesState extends ConsumerState<RestaurantsPages> {
  List<RestaurantModel> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  Future<void> loadRestaurants() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/mock_data.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);

      setState(() {
        restaurants = jsonData
            .map((json) => RestaurantModel.fromJson(json))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  void _navigateToDetails(RestaurantModel restaurant) {
    Navigator.of(
      context,
    ).pushNamed("/restaurant-details", arguments: restaurant);
  }

  void _logout() {
    Navigator.pop(context); // Fecha o drawer
    ref.read(authControllerProvider.notifier).logout();
    // O AuthChecker vai redirecionar automaticamente para o Login
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
        title: const Text(
          'ReMeals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      drawer: DrawerWidget(drawerItems: _drawerItems(), user: user),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : restaurants.isEmpty
          ? const Center(
              child: Text(
                'Nenhum restaurante encontrado',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: restaurants[index],
                  //Implementar Navegação aqui
                  onTap: () => _navigateToDetails(restaurants[index]),
                );
              },
            ),
    );
  }
}
