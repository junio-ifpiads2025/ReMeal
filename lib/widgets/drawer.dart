import 'package:flutter/material.dart';
import 'package:remeal/models/user.dart';

class DrawerWidget extends StatelessWidget {
  final List<Widget> drawerItems;
  final User? user;
  final Widget? header;
  final EdgeInsetsGeometry? padding;

  const DrawerWidget({
    super.key,
    required this.drawerItems,
    this.user,
    this.header,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header com informações do usuário ou customizado
          if (header != null)
            header!
          else
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: Text(
                user?.name ?? 'Visitante',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _getInitials(user?.name),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),

          // Lista de widgets expansível
          Expanded(
            child: ListView(
              padding: padding ?? EdgeInsets.zero,
              children: drawerItems,
            ),
          ),
        ],
      ),
    );
  }

  /// Retorna as iniciais do nome do usuário
  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }
}
