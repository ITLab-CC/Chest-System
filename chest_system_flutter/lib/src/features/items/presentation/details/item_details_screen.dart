import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/chests_controller.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/details/chest_details_controller.dart';
import 'package:chest_system_flutter/src/features/items/presentation/details/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ItemDetailsScreen extends ConsumerWidget {
  final int id;

  const ItemDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'ID: $id',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          AsyncValueWidget(
            value: ref.watch(itemDetailControllerProvider(id)),
            data: (state) {
              if (state == null) {
                return const Text('No data');
              }
              final items = state.chests;
              return Column(
                children: [
                  Text('Name: ${state.name}'),
                  if (items == null)
                    const Text('No Chests')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(items[index].chestName),
                          subtitle: Text('Quantity: ${items[index].quantity}'),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
