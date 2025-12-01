import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/providers/theme_provider.dart';
import 'package:remeal/providers/category_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final List<String> _categories = ['Bebidas', 'Doces', 'Salgados', 'Massas'];

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);
    final selectedCategory = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Modo escuro'),
              value: isDark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).setDarkMode(value);
              },
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: selectedCategory ?? _categories.first,
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(categoryProvider.notifier).setCategory(value);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Última categoria',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}