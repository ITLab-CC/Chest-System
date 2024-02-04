import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/details/chest_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChestDetailsScreen extends ConsumerWidget {
  final int id;

  const ChestDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Details'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'ID: $id',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          AsyncValueWidget(
            value: ref.watch(chestDetailControllerProvider(id)),
            data: (state) {
              if (state == null) {
                return const Text('No data');
              }
              final items = state.itemQuantitys;
              return Column(
                children: [
                  Text('Name: ${state.name}'),
                  if (items == null)
                    const Text('No items')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(items[index].itemName),
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
