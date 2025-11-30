import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';
import 'package:remeal/utils/theme_notifier.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isDarkMode = false;
  String? _selectedCategory;
  final List<String> _categories = ['Bebidas', 'Doces', 'Salgados', 'Massas'];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    bool isDark = await Preferences.getDarkMode();
    String? lastCat = await Preferences.getLastCategory();
    setState(() {
      _isDarkMode = isDark;
      _selectedCategory = lastCat ?? _categories.first;
    });
  }

  void _onDarkModeChanged(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    await Preferences.setDarkMode(value);
    ref.read(themeNotifierProvider.notifier).setDark(value);
  }

  void _onCategoryChanged(String? value) async {
    if (value == null) return;
    setState(() {
      _selectedCategory = value;
    });
    await Preferences.setLastCategory(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Modo escuro'),
              value: _isDarkMode,
              onChanged: _onDarkModeChanged,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: _onCategoryChanged,
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