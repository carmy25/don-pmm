// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waybills_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$waybillsByCarHash() => r'e094ba0eafe5bdb5c3a45284f2e35de64c4a5e2f';

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

/// See also [waybillsByCar].
@ProviderFor(waybillsByCar)
const waybillsByCarProvider = WaybillsByCarFamily();

/// See also [waybillsByCar].
class WaybillsByCarFamily extends Family<List<Waybill>> {
  /// See also [waybillsByCar].
  const WaybillsByCarFamily();

  /// See also [waybillsByCar].
  WaybillsByCarProvider call(
    Car car,
  ) {
    return WaybillsByCarProvider(
      car,
    );
  }

  @override
  WaybillsByCarProvider getProviderOverride(
    covariant WaybillsByCarProvider provider,
  ) {
    return call(
      provider.car,
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
  String? get name => r'waybillsByCarProvider';
}

/// See also [waybillsByCar].
class WaybillsByCarProvider extends AutoDisposeProvider<List<Waybill>> {
  /// See also [waybillsByCar].
  WaybillsByCarProvider(
    Car car,
  ) : this._internal(
          (ref) => waybillsByCar(
            ref as WaybillsByCarRef,
            car,
          ),
          from: waybillsByCarProvider,
          name: r'waybillsByCarProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$waybillsByCarHash,
          dependencies: WaybillsByCarFamily._dependencies,
          allTransitiveDependencies:
              WaybillsByCarFamily._allTransitiveDependencies,
          car: car,
        );

  WaybillsByCarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.car,
  }) : super.internal();

  final Car car;

  @override
  Override overrideWith(
    List<Waybill> Function(WaybillsByCarRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WaybillsByCarProvider._internal(
        (ref) => create(ref as WaybillsByCarRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        car: car,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Waybill>> createElement() {
    return _WaybillsByCarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WaybillsByCarProvider && other.car == car;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, car.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WaybillsByCarRef on AutoDisposeProviderRef<List<Waybill>> {
  /// The parameter `car` of this provider.
  Car get car;
}

class _WaybillsByCarProviderElement
    extends AutoDisposeProviderElement<List<Waybill>> with WaybillsByCarRef {
  _WaybillsByCarProviderElement(super.provider);

  @override
  Car get car => (origin as WaybillsByCarProvider).car;
}

String _$waybillsByCarAndDateHash() =>
    r'ecfd63e922bc48d62ef0db9bd55e39c7bdd4099a';

/// See also [waybillsByCarAndDate].
@ProviderFor(waybillsByCarAndDate)
const waybillsByCarAndDateProvider = WaybillsByCarAndDateFamily();

/// See also [waybillsByCarAndDate].
class WaybillsByCarAndDateFamily extends Family<List<Waybill>> {
  /// See also [waybillsByCarAndDate].
  const WaybillsByCarAndDateFamily();

  /// See also [waybillsByCarAndDate].
  WaybillsByCarAndDateProvider call(
    Car car,
    DateTime after,
  ) {
    return WaybillsByCarAndDateProvider(
      car,
      after,
    );
  }

  @override
  WaybillsByCarAndDateProvider getProviderOverride(
    covariant WaybillsByCarAndDateProvider provider,
  ) {
    return call(
      provider.car,
      provider.after,
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
  String? get name => r'waybillsByCarAndDateProvider';
}

/// See also [waybillsByCarAndDate].
class WaybillsByCarAndDateProvider extends AutoDisposeProvider<List<Waybill>> {
  /// See also [waybillsByCarAndDate].
  WaybillsByCarAndDateProvider(
    Car car,
    DateTime after,
  ) : this._internal(
          (ref) => waybillsByCarAndDate(
            ref as WaybillsByCarAndDateRef,
            car,
            after,
          ),
          from: waybillsByCarAndDateProvider,
          name: r'waybillsByCarAndDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$waybillsByCarAndDateHash,
          dependencies: WaybillsByCarAndDateFamily._dependencies,
          allTransitiveDependencies:
              WaybillsByCarAndDateFamily._allTransitiveDependencies,
          car: car,
          after: after,
        );

  WaybillsByCarAndDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.car,
    required this.after,
  }) : super.internal();

  final Car car;
  final DateTime after;

  @override
  Override overrideWith(
    List<Waybill> Function(WaybillsByCarAndDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WaybillsByCarAndDateProvider._internal(
        (ref) => create(ref as WaybillsByCarAndDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        car: car,
        after: after,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Waybill>> createElement() {
    return _WaybillsByCarAndDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WaybillsByCarAndDateProvider &&
        other.car == car &&
        other.after == after;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, car.hashCode);
    hash = _SystemHash.combine(hash, after.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WaybillsByCarAndDateRef on AutoDisposeProviderRef<List<Waybill>> {
  /// The parameter `car` of this provider.
  Car get car;

  /// The parameter `after` of this provider.
  DateTime get after;
}

class _WaybillsByCarAndDateProviderElement
    extends AutoDisposeProviderElement<List<Waybill>>
    with WaybillsByCarAndDateRef {
  _WaybillsByCarAndDateProviderElement(super.provider);

  @override
  Car get car => (origin as WaybillsByCarAndDateProvider).car;
  @override
  DateTime get after => (origin as WaybillsByCarAndDateProvider).after;
}

String _$waybillListHash() => r'021a1c65ee80f4d3f227739239fe5ed26c4054e2';

/// See also [WaybillList].
@ProviderFor(WaybillList)
final waybillListProvider =
    AsyncNotifierProvider<WaybillList, List<Waybill>>.internal(
  WaybillList.new,
  name: r'waybillListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$waybillListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WaybillList = AsyncNotifier<List<Waybill>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
