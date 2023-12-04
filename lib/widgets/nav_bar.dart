import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Top Navigation Bar'),
      actions: _buildNavBarButtons(context),
    );
  }

  List<Widget> _buildNavBarButtons(BuildContext context) {
    return [
      'Faculty',
      'Student',
      'Logout',
    ].map((label) => _buildButton(context, label)).toList();
  }

  Widget _buildButton(BuildContext context, String label) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/${label.toLowerCase()}');
      },
      child: Text(label),
    );
  }
}