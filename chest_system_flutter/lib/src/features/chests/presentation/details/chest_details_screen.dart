import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/common_widgets/buttons.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/details/chest_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChestDetailsScreen extends ConsumerWidget {
  const ChestDetailsScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddItemToChestScreen(
            chestId: id,
            context: context,
            ref: ref,
          ).displayDialog();
        },
        child: const Icon(Icons.add),
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
              final items = state.chest?.itemQuantitys;
              return Column(
                children: [
                  Text('Name: ${state.chest?.name ?? 'No name'}'),
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

class AddItemToChestScreen {
  const AddItemToChestScreen({
    required this.chestId,
    required this.context,
    required this.ref,
  });
  final int chestId;
  final BuildContext context;
  final WidgetRef ref;

  Future<void> displayDialog() async {
    // Load all items
    await ref
        .read(chestDetailControllerProvider(chestId).notifier)
        .loadAllItems();
    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      // barrierColor: MyAppColorScheme.myBackgroundColor.withOpacity(0.9),
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item to Chest'),
          content: AsyncValueWidget(
            value: ref.watch(chestDetailControllerProvider(chestId)),
            data: (state) {
              if (state == null) {
                return const Text('No data');
              }
              final items = state.allItems;
              if (items == null) {
                return const Text('No items');
              }
              return Container(
                  height: 300.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index].name),
                        textColor: state.itemSelection != null &&
                                state.itemSelection!.any((element) =>
                                    element.itemId == items[index].id)
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        onTap: () {
                          ref
                              .read(chestDetailControllerProvider(chestId)
                                  .notifier)
                              .selectItem(items[index]);
                        },
                      );
                    },
                  ));
            },
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            CancleButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            PrimaryButton(
              text: 'Add',
              onPressed: () {
                ref
                    .read(chestDetailControllerProvider(chestId).notifier)
                    .finishSelection();
                ref.invalidate(chestDetailControllerProvider(chestId));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
