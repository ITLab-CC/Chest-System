import 'package:chest_system_flutter/src/common_widgets/buttons.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/chests_controller.dart';
import 'package:chest_system_flutter/src/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateChestOverlay {
  CreateChestOverlay({
    required this.context,
    required this.ref,
  });

  final BuildContext context;
  final WidgetRef ref;
  final TextEditingController _chestNameController = TextEditingController();

  Future<void> displayDialog() async {
    return showDialog(
      context: context,
      // barrierColor: MyAppColorScheme.myBackgroundColor.withOpacity(0.9),
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      builder: (context) {
        return AlertDialog(
          title: Text(context.loc.createChest),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _chestNameController,
                decoration: InputDecoration(
                  labelText: context.loc.chestName,
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
                ref
                    .read(chestsControllerProvider.notifier)
                    .createChest(_chestNameController.text);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
