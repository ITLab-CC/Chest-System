import 'package:flutter/material.dart';
import 'package:chest_system_flutter/src/common_widgets/async_value_widget.dart';
import 'package:chest_system_flutter/src/features/chests/presentation/chests_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChestsScreen extends ConsumerWidget {
  const ChestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: AsyncValueWidget(
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
              );
            },
          );
        },
      ),
    );
  }
}
