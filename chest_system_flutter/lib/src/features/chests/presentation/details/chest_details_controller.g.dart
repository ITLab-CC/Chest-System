// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chest_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chestDetailControllerHash() =>
    r'f924ae2399805e733307e188790fac62a62e4475';

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

abstract class _$ChestDetailController
    extends BuildlessAutoDisposeAsyncNotifier<Chest?> {
  late final int id;

  FutureOr<Chest?> build(
    int id,
  );
}

/// See also [ChestDetailController].
@ProviderFor(ChestDetailController)
const chestDetailControllerProvider = ChestDetailControllerFamily();

/// See also [ChestDetailController].
class ChestDetailControllerFamily extends Family<AsyncValue<Chest?>> {
  /// See also [ChestDetailController].
  const ChestDetailControllerFamily();

  /// See also [ChestDetailController].
  ChestDetailControllerProvider call(
    int id,
  ) {
    return ChestDetailControllerProvider(
      id,
    );
  }

  @override
  ChestDetailControllerProvider getProviderOverride(
    covariant ChestDetailControllerProvider provider,
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
  String? get name => r'chestDetailControllerProvider';
}

/// See also [ChestDetailController].
class ChestDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChestDetailController,
        Chest?> {
  /// See also [ChestDetailController].
  ChestDetailControllerProvider(
    int id,
  ) : this._internal(
          () => ChestDetailController()..id = id,
          from: chestDetailControllerProvider,
          name: r'chestDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chestDetailControllerHash,
          dependencies: ChestDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              ChestDetailControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ChestDetailControllerProvider._internal(
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
  FutureOr<Chest?> runNotifierBuild(
    covariant ChestDetailController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ChestDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChestDetailControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChestDetailController, Chest?>
      createElement() {
    return _ChestDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChestDetailControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChestDetailControllerRef on AutoDisposeAsyncNotifierProviderRef<Chest?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ChestDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChestDetailController,
        Chest?> with ChestDetailControllerRef {
  _ChestDetailControllerProviderElement(super.provider);

  @override
  int get id => (origin as ChestDetailControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
