import 'package:chest_system_flutter/src/features/chests/presentation/create_chest_overlay.dart';
import 'package:chest_system_flutter/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/chests_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChestsScreen extends ConsumerWidget {
  const ChestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chests'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              CreateChestOverlay(context: context, ref: ref).displayDialog();
            },
          ),
        ],
      ),
      body: AsyncValueWidget(
        value: ref.watch(chestsControllerProvider),
        data: (state) {
          if (state == null) {
            return const Text('No data');
          }
          return ListView.builder(
            itemCount: state.chests.length,
            itemBuilder: (context, index) {
              final chest = state.chests[index];
              return ListTile(
                title: Text(chest.name),
                subtitle: Text(chest.id.toString()),
                onTap: () {
                  context.goNamed(SubRoutes.chestDetails.name,
                      pathParameters: {'id': chest.id.toString()});
                },
              );
            },
          );
        },
      ),
    );
  }
}
