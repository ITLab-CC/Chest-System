import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../constants/api.dart';
import '../../../exceptions/api_exception.dart';
import '../../../utils/dio_provider.dart';
import '../../../utils/logger.dart';
import '../domain/chest.dart';
part 'chest_repository.g.dart';

class ChestRepository {
  ChestRepository({required this.dio});
  final Dio dio;

  String _getUrl({int? id, bool withItems = false}) {
    if (withItems && id == null) {
      throw Error();
    }
    const path = Api.apiPrefix + Api.chestPath;
    final url =
        Uri(scheme: Api.schema, host: Api.host, port: Api.port, path: path)
            .toString();
    if (id != null) {
      if (withItems) {
        return '$url/$id/items';
      }
      return '$url/$id';
    } else {
      return url;
    }
  }

  Future<Chest> getChestById({required int id}) async {
    final url = _getUrl(id: id);
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get<String>(url);
    if (response.statusCode == 200 && response.data != null) {
      final chest =
          Chest.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return chest;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getChestById ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<List<Chest>> getChest() async {
    logger.d('chest_repository.getChest');
    final url = _getUrl();
    final response = await dio.get<List<dynamic>>(url);
    if (response.statusCode == 200 && response.data != null) {
      final dataList = response.data!;
      return dataList
          .map(
            (chestJson) => Chest.fromJson(chestJson as Map<String, Object?>),
          )
          .toList();
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getChest ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Chest> getChestWithItems(int id) async {
    final url = _getUrl(id: id, withItems: true);
    final response = await dio.get<Map<String, dynamic>>(url);
    if (response.statusCode == 200 && response.data != null) {
      final chest = Chest.fromJson(response.data!);
      return chest;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getChestWithItems ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Chest> updateChest({required Chest chest}) async {
    final url = _getUrl(id: chest.id);
    final response = await dio.put<String>(url, data: chest.toJson());
    if (response.statusCode == 200 && response.data != null) {
      final chestUpdated =
          Chest.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return chestUpdated;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'updateOwner ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<bool> deleteChest(int id) async {
    final url = _getUrl(id: id);
    final response = await dio.delete<String>(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'deleteChest ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Chest> createChest(Chest chest) async {
    final url = _getUrl();
    // this api uses the id if it exists, hence in case of a post
    // we make sure, there is no id
    final response = await dio.post<String>(url, data: chest.toJsonWithoutId());
    if (response.statusCode == 201 && response.data != null) {
      final newChest =
          Chest.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return newChest;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'saveChest ${response.statusCode}, data=${response.data}',
      );
    }
  }
}

@riverpod
ChestRepository chestRepository(ChestRepositoryRef ref) =>
    ChestRepository(dio: ref.read(dioProvider));

// @riverpod
// Future<List<Chest>> fetchChest(FetchChestRef ref) async {
//   logger.d('chest_repository.fetchChest');
//   final repo = ref.read(chestRepositoryProvider);
//   return repo.getChest();
// }

// @riverpod
// Future<Chest> fetchChestById(FetchChestByIdRef ref, int id) async {
//   final repo = ref.read(chestRepositoryProvider);
//   return repo.getChestById(id: id);
// }

