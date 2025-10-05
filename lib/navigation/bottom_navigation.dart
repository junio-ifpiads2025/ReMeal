import 'package:flutter/material.dart';
import 'package:remeal/pages/profile_page.dart';
import 'package:remeal/pages/restaurants_page.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // Lista de páginas
  final List<Widget> _pages = const [
    RestaurantsPages(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // muda a tela conforme item selecionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // item atual
        onTap: _onItemTapped, // ação ao clicar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Restaurantes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
