import 'dart:convert';
import 'package:remeal/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/restaurant_model.dart';
import '../widgets/restaurant_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/controller/auth_provider.dart';
import 'package:remeal/providers/category_provider.dart';

class RestaurantsPages extends ConsumerStatefulWidget {
  const RestaurantsPages({super.key});

  @override
  ConsumerState<RestaurantsPages> createState() => _RestaurantsPagesState();
}

class _RestaurantsPagesState extends ConsumerState<RestaurantsPages>
    with TickerProviderStateMixin {
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> filteredRestaurants = [];
  bool isLoading = true;
  bool isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;

  final List<String> _categories = [
    'Regional',
    'Frutos do Mar',
    'Contemporânea',
    'Latina',
    'Bar'
  ];

  @override
  void initState() {
    super.initState();
    loadRestaurants();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _searchController.addListener(_filterRestaurants);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
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
        filteredRestaurants = restaurants;
        isLoading = false;
      });
      
      // Debug: verificar se as categorias estão corretas
      for (var restaurant in restaurants) {
        print('${restaurant.name} - Categoria: "${restaurant.category}"');
      }
      
      // Aplicar filtro após carregar os restaurantes
      Future.microtask(() => _filterRestaurants());
    } catch (e) {
      print('Erro ao carregar restaurantes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    final selectedCategory = ref.read(categoryProvider);
    
    setState(() {
      filteredRestaurants = restaurants.where((restaurant) {
        final matchesSearch = query.isEmpty ||
            restaurant.name.toLowerCase().contains(query) ||
            restaurant.description.toLowerCase().contains(query);

        final matchesCategory = selectedCategory == null ||
            selectedCategory.isEmpty ||
            restaurant.category.trim() == selectedCategory.trim();

        return matchesSearch && matchesCategory;
      }).toList();
    });
    
  }

  void _toggleSearch() {
    setState(() {
      isSearchExpanded = !isSearchExpanded;
      if (isSearchExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final selectedCategory = ref.read(categoryProvider);
        return AlertDialog(
          title: const Text('Filtrar por Categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Todas as categorias'),
                leading: Radio<String?>(
                  value: null,
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    ref.read(categoryProvider.notifier).setCategory(value);
                    Navigator.pop(context);
                  },
                ),
              ),
              ..._categories.map((category) {
                return ListTile(
                  title: Text(category),
                  leading: Radio<String?>(
                    value: category,
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      ref.read(categoryProvider.notifier).setCategory(value);
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDetails(RestaurantModel restaurant) {
    Navigator.of(context).pushNamed("/restaurant-details", arguments: restaurant);
  }

  void _logout() {
    Navigator.pop(context);
    ref.read(authControllerProvider.notifier).logout();
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
    final selectedCategory = ref.watch(categoryProvider);

    // Escuta mudanças na categoria para filtrar
    ref.listen(categoryProvider, (previous, next) {
      _filterRestaurants();
    });

    return Scaffold(
      appBar: AppBar(
        title: !isSearchExpanded
            ? Text(
                'ReMeals',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        backgroundColor: Colors.transparent,
        actions: [
          // Barra de pesquisa expansível
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSearchExpanded ? MediaQuery.of(context).size.width - 120 : 48,
            child: Row(
              children: [
                if (isSearchExpanded)
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar restaurantes...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    isSearchExpanded ? Icons.close : Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _toggleSearch,
                ),
              ],
            ),
          ),
          // Botão de filtro
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).colorScheme.primary,
                ),
                if (selectedCategory != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      drawer: DrawerWidget(drawerItems: _drawerItems(), user: user),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Indicador de filtros ativos
                if (selectedCategory != null || _searchController.text.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Wrap(
                      spacing: 8,
                      children: [
                        if (selectedCategory != null)
                          Chip(
                            label: Text(selectedCategory),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              ref.read(categoryProvider.notifier).clearFilter();
                            },
                          ),
                        if (_searchController.text.isNotEmpty)
                          Chip(
                            label: Text('Busca: "${_searchController.text}"'),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              _searchController.clear();
                            },
                          ),
                      ],
                    ),
                  ),
                // Lista de restaurantes
                Expanded(
                  child: filteredRestaurants.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant_menu,
                                size: 64,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhum restaurante encontrado',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: filteredRestaurants.length,
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                              restaurant: filteredRestaurants[index],
                              onTap: () => _navigateToDetails(filteredRestaurants[index]),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
