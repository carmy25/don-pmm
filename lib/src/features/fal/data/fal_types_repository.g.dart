// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fal_types_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$falTypeByNameAndDensityHash() =>
    r'8165c9393d9e6ae175aaf9cb5a6c42198ec41dec';

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

/// See also [falTypeByNameAndDensity].
@ProviderFor(falTypeByNameAndDensity)
const falTypeByNameAndDensityProvider = FalTypeByNameAndDensityFamily();

/// See also [falTypeByNameAndDensity].
class FalTypeByNameAndDensityFamily extends Family<FALType?> {
  /// See also [falTypeByNameAndDensity].
  const FalTypeByNameAndDensityFamily();

  /// See also [falTypeByNameAndDensity].
  FalTypeByNameAndDensityProvider call(
    String value, {
    double? density,
  }) {
    return FalTypeByNameAndDensityProvider(
      value,
      density: density,
    );
  }

  @override
  FalTypeByNameAndDensityProvider getProviderOverride(
    covariant FalTypeByNameAndDensityProvider provider,
  ) {
    return call(
      provider.value,
      density: provider.density,
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
  String? get name => r'falTypeByNameAndDensityProvider';
}

/// See also [falTypeByNameAndDensity].
class FalTypeByNameAndDensityProvider extends AutoDisposeProvider<FALType?> {
  /// See also [falTypeByNameAndDensity].
  FalTypeByNameAndDensityProvider(
    String value, {
    double? density,
  }) : this._internal(
          (ref) => falTypeByNameAndDensity(
            ref as FalTypeByNameAndDensityRef,
            value,
            density: density,
          ),
          from: falTypeByNameAndDensityProvider,
          name: r'falTypeByNameAndDensityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$falTypeByNameAndDensityHash,
          dependencies: FalTypeByNameAndDensityFamily._dependencies,
          allTransitiveDependencies:
              FalTypeByNameAndDensityFamily._allTransitiveDependencies,
          value: value,
          density: density,
        );

  FalTypeByNameAndDensityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
    required this.density,
  }) : super.internal();

  final String value;
  final double? density;

  @override
  Override overrideWith(
    FALType? Function(FalTypeByNameAndDensityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FalTypeByNameAndDensityProvider._internal(
        (ref) => create(ref as FalTypeByNameAndDensityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        value: value,
        density: density,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FALType?> createElement() {
    return _FalTypeByNameAndDensityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FalTypeByNameAndDensityProvider &&
        other.value == value &&
        other.density == density;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);
    hash = _SystemHash.combine(hash, density.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FalTypeByNameAndDensityRef on AutoDisposeProviderRef<FALType?> {
  /// The parameter `value` of this provider.
  String get value;

  /// The parameter `density` of this provider.
  double? get density;
}

class _FalTypeByNameAndDensityProviderElement
    extends AutoDisposeProviderElement<FALType?>
    with FalTypeByNameAndDensityRef {
  _FalTypeByNameAndDensityProviderElement(super.provider);

  @override
  String get value => (origin as FalTypeByNameAndDensityProvider).value;
  @override
  double? get density => (origin as FalTypeByNameAndDensityProvider).density;
}

String _$falTypesRepositoryHash() =>
    r'89e02c26c59ed50a8c01dee7bfed8308b8660c4a';

/// See also [FalTypesRepository].
@ProviderFor(FalTypesRepository)
final falTypesRepositoryProvider =
    AsyncNotifierProvider<FalTypesRepository, List<FALType>>.internal(
  FalTypesRepository.new,
  name: r'falTypesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$falTypesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FalTypesRepository = AsyncNotifier<List<FALType>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
