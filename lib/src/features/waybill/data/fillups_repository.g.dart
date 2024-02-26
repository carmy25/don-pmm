// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fillups_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fillupsByWaybillHash() => r'2eebd304ca57e49807e2765511ded750695a3209';

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

/// See also [fillupsByWaybill].
@ProviderFor(fillupsByWaybill)
const fillupsByWaybillProvider = FillupsByWaybillFamily();

/// See also [fillupsByWaybill].
class FillupsByWaybillFamily extends Family<List<Fillup>> {
  /// See also [fillupsByWaybill].
  const FillupsByWaybillFamily();

  /// See also [fillupsByWaybill].
  FillupsByWaybillProvider call(
    Waybill waybill,
  ) {
    return FillupsByWaybillProvider(
      waybill,
    );
  }

  @override
  FillupsByWaybillProvider getProviderOverride(
    covariant FillupsByWaybillProvider provider,
  ) {
    return call(
      provider.waybill,
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
  String? get name => r'fillupsByWaybillProvider';
}

/// See also [fillupsByWaybill].
class FillupsByWaybillProvider extends AutoDisposeProvider<List<Fillup>> {
  /// See also [fillupsByWaybill].
  FillupsByWaybillProvider(
    Waybill waybill,
  ) : this._internal(
          (ref) => fillupsByWaybill(
            ref as FillupsByWaybillRef,
            waybill,
          ),
          from: fillupsByWaybillProvider,
          name: r'fillupsByWaybillProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fillupsByWaybillHash,
          dependencies: FillupsByWaybillFamily._dependencies,
          allTransitiveDependencies:
              FillupsByWaybillFamily._allTransitiveDependencies,
          waybill: waybill,
        );

  FillupsByWaybillProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.waybill,
  }) : super.internal();

  final Waybill waybill;

  @override
  Override overrideWith(
    List<Fillup> Function(FillupsByWaybillRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FillupsByWaybillProvider._internal(
        (ref) => create(ref as FillupsByWaybillRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        waybill: waybill,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Fillup>> createElement() {
    return _FillupsByWaybillProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FillupsByWaybillProvider && other.waybill == waybill;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, waybill.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FillupsByWaybillRef on AutoDisposeProviderRef<List<Fillup>> {
  /// The parameter `waybill` of this provider.
  Waybill get waybill;
}

class _FillupsByWaybillProviderElement
    extends AutoDisposeProviderElement<List<Fillup>> with FillupsByWaybillRef {
  _FillupsByWaybillProviderElement(super.provider);

  @override
  Waybill get waybill => (origin as FillupsByWaybillProvider).waybill;
}

String _$fillupByFalTypeHash() => r'3ac344de7a339f4b1e7e4afe19de848722e3eafa';

/// See also [fillupByFalType].
@ProviderFor(fillupByFalType)
const fillupByFalTypeProvider = FillupByFalTypeFamily();

/// See also [fillupByFalType].
class FillupByFalTypeFamily extends Family<Fillup?> {
  /// See also [fillupByFalType].
  const FillupByFalTypeFamily();

  /// See also [fillupByFalType].
  FillupByFalTypeProvider call(
    FALType falType,
  ) {
    return FillupByFalTypeProvider(
      falType,
    );
  }

  @override
  FillupByFalTypeProvider getProviderOverride(
    covariant FillupByFalTypeProvider provider,
  ) {
    return call(
      provider.falType,
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
  String? get name => r'fillupByFalTypeProvider';
}

/// See also [fillupByFalType].
class FillupByFalTypeProvider extends AutoDisposeProvider<Fillup?> {
  /// See also [fillupByFalType].
  FillupByFalTypeProvider(
    FALType falType,
  ) : this._internal(
          (ref) => fillupByFalType(
            ref as FillupByFalTypeRef,
            falType,
          ),
          from: fillupByFalTypeProvider,
          name: r'fillupByFalTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fillupByFalTypeHash,
          dependencies: FillupByFalTypeFamily._dependencies,
          allTransitiveDependencies:
              FillupByFalTypeFamily._allTransitiveDependencies,
          falType: falType,
        );

  FillupByFalTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.falType,
  }) : super.internal();

  final FALType falType;

  @override
  Override overrideWith(
    Fillup? Function(FillupByFalTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FillupByFalTypeProvider._internal(
        (ref) => create(ref as FillupByFalTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        falType: falType,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Fillup?> createElement() {
    return _FillupByFalTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FillupByFalTypeProvider && other.falType == falType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, falType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FillupByFalTypeRef on AutoDisposeProviderRef<Fillup?> {
  /// The parameter `falType` of this provider.
  FALType get falType;
}

class _FillupByFalTypeProviderElement
    extends AutoDisposeProviderElement<Fillup?> with FillupByFalTypeRef {
  _FillupByFalTypeProviderElement(super.provider);

  @override
  FALType get falType => (origin as FillupByFalTypeProvider).falType;
}

String _$fillupFalTypesHash() => r'76469f83b7526060f38e835f98e1259df160fdcf';

/// See also [fillupFalTypes].
@ProviderFor(fillupFalTypes)
final fillupFalTypesProvider = AutoDisposeProvider<List<FALType>>.internal(
  fillupFalTypes,
  name: r'fillupFalTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fillupFalTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FillupFalTypesRef = AutoDisposeProviderRef<List<FALType>>;
String _$fillupListHash() => r'50cf75d1cf4f4b457fd55a74099233dea02340e6';

/// See also [FillupList].
@ProviderFor(FillupList)
final fillupListProvider =
    AsyncNotifierProvider<FillupList, List<Fillup>>.internal(
  FillupList.new,
  name: r'fillupListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fillupListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FillupList = AsyncNotifier<List<Fillup>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
