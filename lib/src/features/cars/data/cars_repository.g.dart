// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$carByUuidHash() => r'bffa9b37c42d9c0ab54b946d8237c5ee5b1d5424';

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

/// See also [carByUuid].
@ProviderFor(carByUuid)
const carByUuidProvider = CarByUuidFamily();

/// See also [carByUuid].
class CarByUuidFamily extends Family<Car> {
  /// See also [carByUuid].
  const CarByUuidFamily();

  /// See also [carByUuid].
  CarByUuidProvider call(
    String uuid,
  ) {
    return CarByUuidProvider(
      uuid,
    );
  }

  @override
  CarByUuidProvider getProviderOverride(
    covariant CarByUuidProvider provider,
  ) {
    return call(
      provider.uuid,
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
  String? get name => r'carByUuidProvider';
}

/// See also [carByUuid].
class CarByUuidProvider extends AutoDisposeProvider<Car> {
  /// See also [carByUuid].
  CarByUuidProvider(
    String uuid,
  ) : this._internal(
          (ref) => carByUuid(
            ref as CarByUuidRef,
            uuid,
          ),
          from: carByUuidProvider,
          name: r'carByUuidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$carByUuidHash,
          dependencies: CarByUuidFamily._dependencies,
          allTransitiveDependencies: CarByUuidFamily._allTransitiveDependencies,
          uuid: uuid,
        );

  CarByUuidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uuid,
  }) : super.internal();

  final String uuid;

  @override
  Override overrideWith(
    Car Function(CarByUuidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CarByUuidProvider._internal(
        (ref) => create(ref as CarByUuidRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uuid: uuid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Car> createElement() {
    return _CarByUuidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CarByUuidProvider && other.uuid == uuid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uuid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CarByUuidRef on AutoDisposeProviderRef<Car> {
  /// The parameter `uuid` of this provider.
  String get uuid;
}

class _CarByUuidProviderElement extends AutoDisposeProviderElement<Car>
    with CarByUuidRef {
  _CarByUuidProviderElement(super.provider);

  @override
  String get uuid => (origin as CarByUuidProvider).uuid;
}

String _$carListHash() => r'e90d13f5cd26b4ddbe42026ce0ee6df03efbbf69';

/// See also [CarList].
@ProviderFor(CarList)
final carListProvider = AsyncNotifierProvider<CarList, List<Car>>.internal(
  CarList.new,
  name: r'carListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$carListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CarList = AsyncNotifier<List<Car>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
