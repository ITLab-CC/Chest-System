import 'package:chest_system_flutter/src/features/items/data/item_repository.dart';
import 'package:chest_system_flutter/src/features/items/domain/item.dart';
import 'package:chest_system_flutter/src/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'item_details_controller.g.dart';

@riverpod
class ItemDetailController extends _$ItemDetailController {
  @override
  FutureOr<Item?> build(int id) {
    loadItem(id);
    return null;
  }

  Future<void> loadItem(int id) async {
    print('loadItem');
    state = const AsyncLoading<Item?>();
    try {
      final item = await ref.read(itemRepositoryProvider).getItemWithChests(id);
      state = AsyncData(item);
    } catch (e) {
      logger.e('loadItem error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}
