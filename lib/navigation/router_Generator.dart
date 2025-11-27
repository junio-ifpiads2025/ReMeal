import 'package:flutter/material.dart';
import 'package:remeal/models/restaurant_model.dart';
import 'package:remeal/navigation/bottom_navigation.dart';
import 'package:remeal/pages/restaurant_details_page.dart';
import 'package:remeal/pages/restaurants_page.dart';
import 'package:remeal/pages/profile_settings.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case '/restaurants':
        return MaterialPageRoute(builder: (_) => RestaurantsPages());
      case '/restaurant-details':
        return MaterialPageRoute(builder: (_) => RestaurantDetailsPage(
          restaurant: settings.arguments as RestaurantModel,
        ));
      case '/settings':
      return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
