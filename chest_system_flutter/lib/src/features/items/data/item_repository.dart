import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../constants/api.dart';
import '../../../exceptions/api_exception.dart';
import '../../../utils/dio_provider.dart';
import '../../../utils/logger.dart';
import '../domain/item.dart';
part 'item_repository.g.dart';

class ItemRepository {
  ItemRepository({required this.dio});
  final Dio dio;

  String _getUrl({int? id, bool withChests = false}) {
    if (withChests && id == null) {
      throw Error();
    }
    const path = Api.apiPrefix + Api.itemPath;
    final url =
        Uri(scheme: Api.schema, host: Api.host, port: Api.port, path: path)
            .toString();
    if (id != null) {
      if (withChests) {
        return '$url/$id/chests';
      }
      return '$url/$id';
    } else {
      return url;
    }
  }

  Future<Item> getItemById({required int id}) async {
    final url = _getUrl(id: id);
    // ignore: inference_failure_on_function_invocation
    final response = await dio.get<String>(url);
    if (response.statusCode == 200 && response.data != null) {
      final item =
          Item.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return item;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getItemById ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<List<Item>> getItems() async {
    logger.d('item_repository.getItems');
    final url = _getUrl();
    final response = await dio.get<List<dynamic>>(url);
    if (response.statusCode == 200 && response.data != null) {
      final dataList = response.data!;
      return dataList
          .map(
            (itemJson) => Item.fromJson(itemJson as Map<String, Object?>),
          )
          .toList();
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getItem ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Item> updateItem({required Item item}) async {
    final url = _getUrl(id: item.id);
    final response = await dio.put<String>(url, data: item.toJson());
    if (response.statusCode == 200 && response.data != null) {
      final itemUpdated =
          Item.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return itemUpdated;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'updateOwner ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<bool> deleteItem(int id) async {
    final url = _getUrl(id: id);
    final response = await dio.delete<String>(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'deleteItem ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Item> createItem(Item item) async {
    final url = _getUrl();
    // this api uses the id if it exists, hence in case of a post
    // we make sure, there is no id
    final response = await dio.post<String>(url, data: item.toJsonWithoutId());
    if (response.statusCode == 201 && response.data != null) {
      final newItem =
          Item.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return newItem;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'saveItem ${response.statusCode}, data=${response.data}',
      );
    }
  }

  Future<Item> getItemWithChests(int id) async {
    final url = _getUrl(id: id, withChests: true);
    final response = await dio.get<String>(url);
    if (response.statusCode == 200 && response.data != null) {
      logger.d('getItemWithChests ${response.data}');
      final item =
          Item.fromJson(json.decode(response.data!) as Map<String, Object?>);
      return item;
    } else {
      throw ApiException(
        response.statusCode ?? -1,
        'getItemWithChests ${response.statusCode}, data=${response.data}',
      );
    }
  }
}

@riverpod
ItemRepository itemRepository(ItemRepositoryRef ref) =>
    ItemRepository(dio: ref.read(dioProvider));

// @riverpod
// Future<List<Item>> fetchItem(FetchItemRef ref) async {
//   logger.d('item_repository.fetchItem');
//   final repo = ref.read(itemRepositoryProvider);
//   return repo.getItem();
// }

// @riverpod
// Future<Item> fetchItemById(FetchItemByIdRef ref, int id) async {
//   final repo = ref.read(itemRepositoryProvider);
//   return repo.getItemById(id: id);
// }

