// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outcomes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$outcomeByFalTypeHash() => r'eeabd0a72d213ee527ee811eb9f100400e34561c';

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

/// See also [outcomeByFalType].
@ProviderFor(outcomeByFalType)
const outcomeByFalTypeProvider = OutcomeByFalTypeFamily();

/// See also [outcomeByFalType].
class OutcomeByFalTypeFamily extends Family<FAL?> {
  /// See also [outcomeByFalType].
  const OutcomeByFalTypeFamily();

  /// See also [outcomeByFalType].
  OutcomeByFalTypeProvider call(
    FALType falType,
  ) {
    return OutcomeByFalTypeProvider(
      falType,
    );
  }

  @override
  OutcomeByFalTypeProvider getProviderOverride(
    covariant OutcomeByFalTypeProvider provider,
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
  String? get name => r'outcomeByFalTypeProvider';
}

/// See also [outcomeByFalType].
class OutcomeByFalTypeProvider extends AutoDisposeProvider<FAL?> {
  /// See also [outcomeByFalType].
  OutcomeByFalTypeProvider(
    FALType falType,
  ) : this._internal(
          (ref) => outcomeByFalType(
            ref as OutcomeByFalTypeRef,
            falType,
          ),
          from: outcomeByFalTypeProvider,
          name: r'outcomeByFalTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$outcomeByFalTypeHash,
          dependencies: OutcomeByFalTypeFamily._dependencies,
          allTransitiveDependencies:
              OutcomeByFalTypeFamily._allTransitiveDependencies,
          falType: falType,
        );

  OutcomeByFalTypeProvider._internal(
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
    FAL? Function(OutcomeByFalTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OutcomeByFalTypeProvider._internal(
        (ref) => create(ref as OutcomeByFalTypeRef),
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
  AutoDisposeProviderElement<FAL?> createElement() {
    return _OutcomeByFalTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OutcomeByFalTypeProvider && other.falType == falType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, falType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OutcomeByFalTypeRef on AutoDisposeProviderRef<FAL?> {
  /// The parameter `falType` of this provider.
  FALType get falType;
}

class _OutcomeByFalTypeProviderElement extends AutoDisposeProviderElement<FAL?>
    with OutcomeByFalTypeRef {
  _OutcomeByFalTypeProviderElement(super.provider);

  @override
  FALType get falType => (origin as OutcomeByFalTypeProvider).falType;
}

String _$outcomesRepositoryHash() =>
    r'ad908ee1ddbf59d2b6a2b658806f6bf0b2a9795b';

/// See also [OutcomesRepository].
@ProviderFor(OutcomesRepository)
final outcomesRepositoryProvider =
    NotifierProvider<OutcomesRepository, List<FAL>>.internal(
  OutcomesRepository.new,
  name: r'outcomesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$outcomesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OutcomesRepository = Notifier<List<FAL>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
