import 'package:chest_system_flutter/src/features/chests/data/chest_repository.dart';
import 'package:chest_system_flutter/src/features/chests/domain/chest.dart';
import 'package:chest_system_flutter/src/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chest_details_controller.g.dart';

@riverpod
class ChestDetailController extends _$ChestDetailController {
  @override
  FutureOr<Chest?> build(int id) {
    loadChest(id);
    return null;
    // return ref.read(chestRepositoryProvider).getChestWithItems(id);
  }

  Future<void> loadChest(int id) async {
    print('loadChest');
    state = const AsyncLoading<Chest?>();
    try {
      final chest =
          await ref.read(chestRepositoryProvider).getChestWithItems(id);
      state = AsyncData(chest);
    } catch (e) {
      logger.e('loadChest error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}
