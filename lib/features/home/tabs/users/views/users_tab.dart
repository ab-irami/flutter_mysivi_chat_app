import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Users Tab',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}