import 'package:chest_system_flutter/src/features/chests/data/chest_repository.dart';
import 'package:chest_system_flutter/src/features/chests/domain/chest.dart';
import 'package:chest_system_flutter/src/features/items/data/item_repository.dart';
import 'package:chest_system_flutter/src/features/items/domain/item.dart';
import 'package:chest_system_flutter/src/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chest_details_controller.g.dart';
part 'chest_details_controller.freezed.dart';

@freezed
class CreateChestItemQuantity with _$CreateChestItemQuantity {
  const factory CreateChestItemQuantity({
    @JsonKey(name: 'item_id') required int itemId,
    @JsonKey(name: 'anzahl') required int quantity,
  }) = _CreateChestItemQuantity;
}

class ChestDetailState {
  final Chest? chest;
  final List<Item>?
      allItems; // Not the items in the chest, but all items in the system (to then assign to the chest)
  final List<CreateChestItemQuantity>?
      itemSelection; // The items that are selected to be added to the chest
  const ChestDetailState({this.chest, this.allItems, this.itemSelection});
}

@Riverpod(keepAlive: true)
class ChestDetailController extends _$ChestDetailController {
  @override
  FutureOr<ChestDetailState?> build(int id) {
    loadChest(id);
    return null;
    // return ref.read(chestRepositoryProvider).getChestWithItems(id);
  }

  Future<void> loadChest(int id) async {
    print('loadChest');
    state = const AsyncLoading<ChestDetailState?>();
    try {
      final chest =
          await ref.read(chestRepositoryProvider).getChestWithItems(id);
      state = AsyncData(ChestDetailState(chest: chest));
      logger.d('loadChest chest $chest');
      // state = AsyncData(chest);
    } catch (e) {
      logger.e('loadChest error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    state = AsyncData(ChestDetailState(
      chest: state.value?.chest,
      allItems: [],
      itemSelection: [],
    ));
    await loadChest(state.value?.chest?.id ?? 0);
  }

  Future<void> loadAllItems() async {
    print('loadAllItems');
    final oldState = state;
    state = const AsyncLoading<ChestDetailState?>();
    try {
      final allItems = await ref.read(itemRepositoryProvider).getItems();
      state = AsyncData(ChestDetailState(
        chest: oldState.value?.chest,
        allItems: allItems,
        itemSelection: oldState.value?.itemSelection,
      ));
      logger.d('loadAllItems allItems $allItems');
    } catch (e) {
      logger.e('loadAllItems error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  void selectItem(Item item) {
    logger.d('selectItem item $item');
    final currentSelection = state.value?.itemSelection ?? [];
    final index =
        currentSelection.indexWhere((element) => element.itemId == item.id);
    if (index == -1) {
      state = AsyncData(ChestDetailState(
        chest: state.value?.chest,
        allItems: state.value?.allItems,
        itemSelection: [
          ...currentSelection,
          CreateChestItemQuantity(itemId: item.id!, quantity: 1)
        ],
      ));
      logger.d('selectItem newSelection ${state.value?.itemSelection}');
      logger.d('chest_id ${state.value?.chest?.id}');
    } else {
      final newSelection = List<CreateChestItemQuantity>.from(currentSelection);
      newSelection[index] = CreateChestItemQuantity(
        itemId: newSelection[index].itemId,
        quantity: newSelection[index].quantity + 1,
      );
      state = AsyncData(ChestDetailState(
        chest: state.value?.chest,
        allItems: state.value?.allItems,
        itemSelection: newSelection,
      ));
    }
  }

  Future<void> finishSelection() async {
    final currentSelection = state.value?.itemSelection ?? [];
    logger.d('finishSelection currentSelection $currentSelection');
    final newSelection = currentSelection
        .where((element) => element.quantity > 0)
        .toList(growable: false);
    logger.d('finishSelection newSelection $newSelection');
    // For each item, add it to the chest
    for (final item in newSelection) {
      await ref.read(chestRepositoryProvider).addItemToChest(
            state.value!.chest!.id!,
            item.itemId,
            item.quantity,
          );
    }
    await refresh();
  }
}
