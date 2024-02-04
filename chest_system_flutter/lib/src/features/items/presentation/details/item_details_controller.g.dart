// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemDetailControllerHash() =>
    r'57c0f8bbe0363f6d107b4bb43bf7ce9ada6f2657';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ItemDetailController
    extends BuildlessAutoDisposeAsyncNotifier<Item?> {
  late final int id;

  FutureOr<Item?> build(
    int id,
  );
}

/// See also [ItemDetailController].
@ProviderFor(ItemDetailController)
const itemDetailControllerProvider = ItemDetailControllerFamily();

/// See also [ItemDetailController].
class ItemDetailControllerFamily extends Family<AsyncValue<Item?>> {
  /// See also [ItemDetailController].
  const ItemDetailControllerFamily();

  /// See also [ItemDetailController].
  ItemDetailControllerProvider call(
    int id,
  ) {
    return ItemDetailControllerProvider(
      id,
    );
  }

  @override
  ItemDetailControllerProvider getProviderOverride(
    covariant ItemDetailControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemDetailControllerProvider';
}

/// See also [ItemDetailController].
class ItemDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ItemDetailController, Item?> {
  /// See also [ItemDetailController].
  ItemDetailControllerProvider(
    int id,
  ) : this._internal(
          () => ItemDetailController()..id = id,
          from: itemDetailControllerProvider,
          name: r'itemDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemDetailControllerHash,
          dependencies: ItemDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              ItemDetailControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ItemDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<Item?> runNotifierBuild(
    covariant ItemDetailController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ItemDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemDetailControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ItemDetailController, Item?>
      createElement() {
    return _ItemDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemDetailControllerRef on AutoDisposeAsyncNotifierProviderRef<Item?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ItemDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ItemDetailController, Item?>
    with ItemDetailControllerRef {
  _ItemDetailControllerProviderElement(super.provider);

  @override
  int get id => (origin as ItemDetailControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
