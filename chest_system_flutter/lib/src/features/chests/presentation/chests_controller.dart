import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/logger.dart';
import '../data/chest_repository.dart';
import '../domain/chest.dart';
part 'chests_controller.g.dart';

class ControllerState {
  ControllerState(this.chests);
  final List<Chest> chests;
}

@riverpod
class ChestsController extends _$ChestsController {
  @override
  FutureOr<ControllerState?> build() {
    ref.onDispose(
      () => logger.i('ChestsController ----- dispose controller -----'),
    );
    reloadController();
    return null;
  }

  Future<void> reloadController() async {
    state = const AsyncLoading<ControllerState?>();
    try {
      final chests = await ref.read(chestRepositoryProvider).getChest();
      state = AsyncData(ControllerState(chests));
    } catch (e) {
      logger.e('reloadController error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> createChest(String name) async {
    try {
      final Chest chest = Chest(name: name);
      await ref.read(chestRepositoryProvider).createChest(chest);
      await reloadController();
    } catch (e) {
      logger.e('createChest error $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}
