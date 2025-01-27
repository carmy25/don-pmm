// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waybills_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$waybillsByCarHash() => r'fd3c91492366cb054f7115c888f24393dc569270';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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

String _$waybillByUuidHash() => r'a6b3ebc5ce14845b7d71a2d891d656fb9f479c3b';

/// See also [waybillByUuid].
@ProviderFor(waybillByUuid)
const waybillByUuidProvider = WaybillByUuidFamily();

/// See also [waybillByUuid].
class WaybillByUuidFamily extends Family<Waybill?> {
  /// See also [waybillByUuid].
  const WaybillByUuidFamily();

  /// See also [waybillByUuid].
  WaybillByUuidProvider call(
    String uuid,
  ) {
    return WaybillByUuidProvider(
      uuid,
    );
  }

  @override
  WaybillByUuidProvider getProviderOverride(
    covariant WaybillByUuidProvider provider,
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
  String? get name => r'waybillByUuidProvider';
}

/// See also [waybillByUuid].
class WaybillByUuidProvider extends AutoDisposeProvider<Waybill?> {
  /// See also [waybillByUuid].
  WaybillByUuidProvider(
    String uuid,
  ) : this._internal(
          (ref) => waybillByUuid(
            ref as WaybillByUuidRef,
            uuid,
          ),
          from: waybillByUuidProvider,
          name: r'waybillByUuidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$waybillByUuidHash,
          dependencies: WaybillByUuidFamily._dependencies,
          allTransitiveDependencies:
              WaybillByUuidFamily._allTransitiveDependencies,
          uuid: uuid,
        );

  WaybillByUuidProvider._internal(
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
    Waybill? Function(WaybillByUuidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WaybillByUuidProvider._internal(
        (ref) => create(ref as WaybillByUuidRef),
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
  AutoDisposeProviderElement<Waybill?> createElement() {
    return _WaybillByUuidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WaybillByUuidProvider && other.uuid == uuid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uuid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WaybillByUuidRef on AutoDisposeProviderRef<Waybill?> {
  /// The parameter `uuid` of this provider.
  String get uuid;
}

class _WaybillByUuidProviderElement extends AutoDisposeProviderElement<Waybill?>
    with WaybillByUuidRef {
  _WaybillByUuidProviderElement(super.provider);

  @override
  String get uuid => (origin as WaybillByUuidProvider).uuid;
}

String _$waybillsByCarAndDateHash() =>
    r'9ccee93780fd645b0af7a291ebd20f52406278a5';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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

String _$waybillsByDateHash() => r'8caaf8a7d941ddb3e9834a941de1acd84977756e';

/// See also [waybillsByDate].
@ProviderFor(waybillsByDate)
const waybillsByDateProvider = WaybillsByDateFamily();

/// See also [waybillsByDate].
class WaybillsByDateFamily extends Family<List<Waybill>> {
  /// See also [waybillsByDate].
  const WaybillsByDateFamily();

  /// See also [waybillsByDate].
  WaybillsByDateProvider call(
    DateTime after,
  ) {
    return WaybillsByDateProvider(
      after,
    );
  }

  @override
  WaybillsByDateProvider getProviderOverride(
    covariant WaybillsByDateProvider provider,
  ) {
    return call(
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
  String? get name => r'waybillsByDateProvider';
}

/// See also [waybillsByDate].
class WaybillsByDateProvider extends AutoDisposeProvider<List<Waybill>> {
  /// See also [waybillsByDate].
  WaybillsByDateProvider(
    DateTime after,
  ) : this._internal(
          (ref) => waybillsByDate(
            ref as WaybillsByDateRef,
            after,
          ),
          from: waybillsByDateProvider,
          name: r'waybillsByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$waybillsByDateHash,
          dependencies: WaybillsByDateFamily._dependencies,
          allTransitiveDependencies:
              WaybillsByDateFamily._allTransitiveDependencies,
          after: after,
        );

  WaybillsByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.after,
  }) : super.internal();

  final DateTime after;

  @override
  Override overrideWith(
    List<Waybill> Function(WaybillsByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WaybillsByDateProvider._internal(
        (ref) => create(ref as WaybillsByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        after: after,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Waybill>> createElement() {
    return _WaybillsByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WaybillsByDateProvider && other.after == after;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, after.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WaybillsByDateRef on AutoDisposeProviderRef<List<Waybill>> {
  /// The parameter `after` of this provider.
  DateTime get after;
}

class _WaybillsByDateProviderElement
    extends AutoDisposeProviderElement<List<Waybill>> with WaybillsByDateRef {
  _WaybillsByDateProviderElement(super.provider);

  @override
  DateTime get after => (origin as WaybillsByDateProvider).after;
}

String _$waybillListHash() => r'82763b2f26221a67091b38c56cf0e75e4841587f';

/// See also [WaybillList].
@ProviderFor(WaybillList)
final waybillListProvider =
    NotifierProvider<WaybillList, List<Waybill>>.internal(
  WaybillList.new,
  name: r'waybillListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$waybillListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WaybillList = Notifier<List<Waybill>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
