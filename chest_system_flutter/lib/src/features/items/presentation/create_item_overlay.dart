import 'package:chest_system_flutter/src/common_widgets/buttons.dart';
import 'package:chest_system_flutter/src/features/items/presentation/items_controller.dart';
import 'package:chest_system_flutter/src/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateItemOverlay {
  CreateItemOverlay({
    required this.context,
    required this.ref,
  });

  final BuildContext context;
  final WidgetRef ref;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();

  Future<void> displayDialog() async {
    // _amountController.text = 100.toString();
    return showDialog(
      context: context,
      // barrierColor: MyAppColorScheme.myBackgroundColor.withOpacity(0.9),
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      builder: (context) {
        return AlertDialog(
          title: Text(context.loc.createItem),
          // content: PlusMinusWidget(
          //   controller: _itemNameController,
          //   unit: context.loc.calories,
          //   widgetType: WidgetType.nutrition,
          //   step: 100,
          // ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(
                  labelText: context.loc.itemName,
                ),
              ),
              TextField(
                controller: _itemDescriptionController,
                decoration: InputDecoration(
                  labelText: context.loc.itemDescription,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            CancleButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            PrimaryButton(
              text: context.loc.createBtn,
              onPressed: () {
                ref.read(itemsControllerProvider.notifier).createItem(
                    _itemNameController.text, _itemDescriptionController.text);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
