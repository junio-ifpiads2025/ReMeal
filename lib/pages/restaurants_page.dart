import 'package:flutter/material.dart';

class RestaurantsPages extends StatefulWidget {
  const RestaurantsPages({super.key});

  @override
  State<RestaurantsPages> createState() => _RestaurantsPagesState();
}

class _RestaurantsPagesState extends State<RestaurantsPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReMeals'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}