// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fal_types_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$falTypeByNameHash() => r'3fae9bea4e27e646a8108e8466e81c04b1d8a791';

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

/// See also [falTypeByName].
@ProviderFor(falTypeByName)
const falTypeByNameProvider = FalTypeByNameFamily();

/// See also [falTypeByName].
class FalTypeByNameFamily extends Family<FALType?> {
  /// See also [falTypeByName].
  const FalTypeByNameFamily();

  /// See also [falTypeByName].
  FalTypeByNameProvider call(
    String value,
  ) {
    return FalTypeByNameProvider(
      value,
    );
  }

  @override
  FalTypeByNameProvider getProviderOverride(
    covariant FalTypeByNameProvider provider,
  ) {
    return call(
      provider.value,
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
  String? get name => r'falTypeByNameProvider';
}

/// See also [falTypeByName].
class FalTypeByNameProvider extends AutoDisposeProvider<FALType?> {
  /// See also [falTypeByName].
  FalTypeByNameProvider(
    String value,
  ) : this._internal(
          (ref) => falTypeByName(
            ref as FalTypeByNameRef,
            value,
          ),
          from: falTypeByNameProvider,
          name: r'falTypeByNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$falTypeByNameHash,
          dependencies: FalTypeByNameFamily._dependencies,
          allTransitiveDependencies:
              FalTypeByNameFamily._allTransitiveDependencies,
          value: value,
        );

  FalTypeByNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
  }) : super.internal();

  final String value;

  @override
  Override overrideWith(
    FALType? Function(FalTypeByNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FalTypeByNameProvider._internal(
        (ref) => create(ref as FalTypeByNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FALType?> createElement() {
    return _FalTypeByNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FalTypeByNameProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FalTypeByNameRef on AutoDisposeProviderRef<FALType?> {
  /// The parameter `value` of this provider.
  String get value;
}

class _FalTypeByNameProviderElement extends AutoDisposeProviderElement<FALType?>
    with FalTypeByNameRef {
  _FalTypeByNameProviderElement(super.provider);

  @override
  String get value => (origin as FalTypeByNameProvider).value;
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
