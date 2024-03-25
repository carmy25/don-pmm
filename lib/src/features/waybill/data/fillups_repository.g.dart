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

String _$fillupsByFalTypeHash() => r'3a81876e7bac933a8ceedd003f9394ccd34f597e';

/// See also [fillupsByFalType].
@ProviderFor(fillupsByFalType)
const fillupsByFalTypeProvider = FillupsByFalTypeFamily();

/// See also [fillupsByFalType].
class FillupsByFalTypeFamily extends Family<List<Fillup>> {
  /// See also [fillupsByFalType].
  const FillupsByFalTypeFamily();

  /// See also [fillupsByFalType].
  FillupsByFalTypeProvider call(
    FALType falType,
  ) {
    return FillupsByFalTypeProvider(
      falType,
    );
  }

  @override
  FillupsByFalTypeProvider getProviderOverride(
    covariant FillupsByFalTypeProvider provider,
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
  String? get name => r'fillupsByFalTypeProvider';
}

/// See also [fillupsByFalType].
class FillupsByFalTypeProvider extends AutoDisposeProvider<List<Fillup>> {
  /// See also [fillupsByFalType].
  FillupsByFalTypeProvider(
    FALType falType,
  ) : this._internal(
          (ref) => fillupsByFalType(
            ref as FillupsByFalTypeRef,
            falType,
          ),
          from: fillupsByFalTypeProvider,
          name: r'fillupsByFalTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fillupsByFalTypeHash,
          dependencies: FillupsByFalTypeFamily._dependencies,
          allTransitiveDependencies:
              FillupsByFalTypeFamily._allTransitiveDependencies,
          falType: falType,
        );

  FillupsByFalTypeProvider._internal(
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
    List<Fillup> Function(FillupsByFalTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FillupsByFalTypeProvider._internal(
        (ref) => create(ref as FillupsByFalTypeRef),
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
  AutoDisposeProviderElement<List<Fillup>> createElement() {
    return _FillupsByFalTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FillupsByFalTypeProvider && other.falType == falType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, falType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FillupsByFalTypeRef on AutoDisposeProviderRef<List<Fillup>> {
  /// The parameter `falType` of this provider.
  FALType get falType;
}

class _FillupsByFalTypeProviderElement
    extends AutoDisposeProviderElement<List<Fillup>> with FillupsByFalTypeRef {
  _FillupsByFalTypeProviderElement(super.provider);

  @override
  FALType get falType => (origin as FillupsByFalTypeProvider).falType;
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
String _$fillupListHash() => r'82c1b050119989d509456bedb421f56ceeac2e7d';

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
