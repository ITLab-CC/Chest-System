import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/features/items/presentation/create_item_overlay.dart';
import 'package:chest_system_flutter/src/features/items/presentation/items_controller.dart';
import 'package:chest_system_flutter/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              CreateItemOverlay(context: context, ref: ref).displayDialog();
            },
          ),
        ],
      ),
      body: AsyncValueWidget(
          value: ref.watch(itemsControllerProvider),
          data: (state) {
            if (state == null) {
              return const Center(child: Text('No data'));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  onTap: () {
                    context.goNamed(SubRoutes.itemDetails.name,
                        pathParameters: {'id': item.id.toString()});
                  },
                );
              },
            );
          }),
    );
  }
}
