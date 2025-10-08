import 'dart:convert';
import 'package:remeal/widgets/drawer.dart';
import 'about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/restaurant_model.dart';
import '../widgets/restaurant_card.dart';

class RestaurantsPages extends StatefulWidget {
  const RestaurantsPages({super.key});

  @override
  State<RestaurantsPages> createState() => _RestaurantsPagesState();
}

class _RestaurantsPagesState extends State<RestaurantsPages> {
  List<RestaurantModel> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  Future<void> loadRestaurants() async {
    try {
      final String jsonString = await rootBundle.loadString('lib/data/mock_data.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      
      setState(() {
        restaurants = jsonData.map((json) => RestaurantModel.fromJson(json)).toList();
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
    Navigator.of(context).pushNamed(
      "/restaurant-details",
      arguments: restaurant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReMeals', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
      ),
      drawer: DrawerWidget(drawerItems: [
         ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            )
      ]),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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