// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waybills_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$waybillsByCarHash() => r'13748d238263fd0467733a9ed46c64f497e009a4';

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
class WaybillsByCarFamily extends Family<AsyncValue<List<Waybill>>> {
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
class WaybillsByCarProvider extends AutoDisposeFutureProvider<List<Waybill>> {
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
    FutureOr<List<Waybill>> Function(WaybillsByCarRef provider) create,
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
  AutoDisposeFutureProviderElement<List<Waybill>> createElement() {
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

mixin WaybillsByCarRef on AutoDisposeFutureProviderRef<List<Waybill>> {
  /// The parameter `car` of this provider.
  Car get car;
}

class _WaybillsByCarProviderElement
    extends AutoDisposeFutureProviderElement<List<Waybill>>
    with WaybillsByCarRef {
  _WaybillsByCarProviderElement(super.provider);

  @override
  Car get car => (origin as WaybillsByCarProvider).car;
}

String _$waybillListHash() => r'24a6330b38ce22432c7e19082bfbb3f7bc2a0a73';

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
