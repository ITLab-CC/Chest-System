import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Items'),
    );
  }
}
