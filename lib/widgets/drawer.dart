import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List<Widget> drawerItems;
  final Widget? header;
  final EdgeInsetsGeometry? padding;

  const DrawerWidget({
    super.key,
    required this.drawerItems,
    this.header,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header opcional (pode ser um DrawerHeader ou qualquer widget personalizado)
          if (header != null)
            header!
          else
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
}