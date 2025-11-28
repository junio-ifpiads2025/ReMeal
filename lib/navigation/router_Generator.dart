import 'package:flutter/material.dart';
import 'package:remeal/models/restaurant_model.dart';
import 'package:remeal/navigation/bottom_navigation.dart';
import 'package:remeal/pages/about_page.dart';
import 'package:remeal/pages/auth/login.dart';
import 'package:remeal/pages/auth/register.dart';
import 'package:remeal/pages/restaurant_details_page.dart';
import 'package:remeal/pages/restaurants_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case '/restaurants':
        return MaterialPageRoute(builder: (_) => RestaurantsPages());
      case '/restaurant-details':
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailsPage(
            restaurant: settings.arguments as RestaurantModel,
          ),
        );
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Rota não encontrada'))),
        );
    }
  }
}
