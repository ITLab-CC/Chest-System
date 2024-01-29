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

  // void getChests() async {
  //   state = const AsyncLoading();
  //   try {
  //     final chests = await ref.read(chestRepositoryProvider).getChest();
  //     state = AsyncData(chests);
  //   } catch (e, s) {
  //     logger.e('getChests', e, s);
  //     state = AsyncError(e);
  //   }
  // }

  Future<void> reloadController() async {
    state = const AsyncLoading<ControllerState?>();
    try {
      final chests = await ref.read(chestRepositoryProvider).getChest();
      state = AsyncData(ControllerState(chests));
    } catch (e, s) {
      logger
        ..e('reloadController')
        ..e(e)
        ..e(s);
      state = AsyncError(e, StackTrace.current);
    }
  }
}
