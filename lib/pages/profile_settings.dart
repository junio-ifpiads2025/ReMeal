import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remeal/utils/preferences.dart';
import 'package:remeal/utils/theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    Provider.of<ThemeNotifier>(context, listen: false).setDark(value);
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
              value: _selectedCategory,
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