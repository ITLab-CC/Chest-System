import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/logger.dart';
import '../data/item_repository.dart';
import '../domain/item.dart';
part 'items_controller.g.dart';

class ControllerState {
  ControllerState(this.items);
  final List<Item> items;
}

@riverpod
class ItemsController extends _$ItemsController {
  @override
  FutureOr<ControllerState?> build() {
    ref.onDispose(
      () => logger.i('ItemsController ----- dispose controller -----'),
    );
    reloadController();
    return null;
  }

  // void getItems() async {
  //   state = const AsyncLoading();
  //   try {
  //     final items = await ref.read(itemRepositoryProvider).getItem();
  //     state = AsyncData(items);
  //   } catch (e, s) {
  //     logger.e('getItems', e, s);
  //     state = AsyncError(e);
  //   }
  // }

  Future<void> reloadController() async {
    state = const AsyncLoading<ControllerState?>();
    try {
      final items = await ref.read(itemRepositoryProvider).getItem();
      state = AsyncData(ControllerState(items));
    } catch (e) {
      logger.e('reloadController error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> createItem(String name, String description) async {
    try {
      Item item = Item(name: name, description: description);
      await ref.read(itemRepositoryProvider).createItem(item);
      reloadController();
    } catch (e) {
      logger.e('createItem error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}
