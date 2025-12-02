// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crud_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AsyncDataNotifier)
const asyncDataProvider = AsyncDataNotifierFamily._();

final class AsyncDataNotifierProvider<T>
    extends $AsyncNotifierProvider<AsyncDataNotifier<T>, T> {
  const AsyncDataNotifierProvider._({
    required AsyncDataNotifierFamily super.from,
    required AsyncDataParams<T> super.argument,
  }) : super(
         retry: null,
         name: r'asyncDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncDataNotifierHash();

  @override
  String toString() {
    return r'asyncDataProvider'
        '<${T}>'
        '($argument)';
  }

  @$internal
  @override
  AsyncDataNotifier<T> create() => AsyncDataNotifier<T>();

  $R _captureGenerics<$R>($R Function<T>() cb) {
    return cb<T>();
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncDataNotifierProvider &&
        other.runtimeType == runtimeType &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, argument);
  }
}

String _$asyncDataNotifierHash() => r'f488641e91be155e1a50f0c3a8349a698f9f77b3';

final class AsyncDataNotifierFamily extends $Family {
  const AsyncDataNotifierFamily._()
    : super(
        retry: null,
        name: r'asyncDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AsyncDataNotifierProvider<T> call<T>(AsyncDataParams<T> params) =>
      AsyncDataNotifierProvider<T>._(argument: params, from: this);

  @override
  String toString() => r'asyncDataProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(AsyncDataNotifier<T> Function<T>() create) =>
      $FamilyOverride(
        from: this,
        createElement: (pointer) {
          final provider = pointer.origin as AsyncDataNotifierProvider;
          return provider._captureGenerics(<T>() {
            provider as AsyncDataNotifierProvider<T>;
            return provider.$view(create: create<T>).$createElement(pointer);
          });
        },
      );

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<T> Function<T>(Ref ref, AsyncDataNotifier<T> notifier) build,
  ) => $FamilyOverride(
    from: this,
    createElement: (pointer) {
      final provider = pointer.origin as AsyncDataNotifierProvider;
      return provider._captureGenerics(<T>() {
        provider as AsyncDataNotifierProvider<T>;
        return provider
            .$view(runNotifierBuildOverride: build<T>)
            .$createElement(pointer);
      });
    },
  );
}

abstract class _$AsyncDataNotifier<T> extends $AsyncNotifier<T> {
  late final _$args = ref.$arg as AsyncDataParams<T>;
  AsyncDataParams<T> get params => _$args;

  FutureOr<T> build(AsyncDataParams<T> params);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<T>, T>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<T>, T>,
              AsyncValue<T>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(PaginatedAsyncDataNotifier)
const paginatedAsyncDataProvider = PaginatedAsyncDataNotifierFamily._();

final class PaginatedAsyncDataNotifierProvider<T>
    extends
        $AsyncNotifierProvider<
          PaginatedAsyncDataNotifier<T>,
          PaginatedData<T>
        > {
  const PaginatedAsyncDataNotifierProvider._({
    required PaginatedAsyncDataNotifierFamily super.from,
    required (PaginatedAsyncDataParams<T>, {bool useOffset, int limit})
    super.argument,
  }) : super(
         retry: null,
         name: r'paginatedAsyncDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paginatedAsyncDataNotifierHash();

  @override
  String toString() {
    return r'paginatedAsyncDataProvider'
        '<${T}>'
        '$argument';
  }

  @$internal
  @override
  PaginatedAsyncDataNotifier<T> create() => PaginatedAsyncDataNotifier<T>();

  $R _captureGenerics<$R>($R Function<T>() cb) {
    return cb<T>();
  }

  @override
  bool operator ==(Object other) {
    return other is PaginatedAsyncDataNotifierProvider &&
        other.runtimeType == runtimeType &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, argument);
  }
}

String _$paginatedAsyncDataNotifierHash() =>
    r'cd4078d29b939f5d91f688ec0ee6671e3200bcc8';

final class PaginatedAsyncDataNotifierFamily extends $Family {
  const PaginatedAsyncDataNotifierFamily._()
    : super(
        retry: null,
        name: r'paginatedAsyncDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PaginatedAsyncDataNotifierProvider<T> call<T>(
    PaginatedAsyncDataParams<T> params, {
    bool useOffset = false,
    int limit = 15,
  }) => PaginatedAsyncDataNotifierProvider<T>._(
    argument: (params, useOffset: useOffset, limit: limit),
    from: this,
  );

  @override
  String toString() => r'paginatedAsyncDataProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(PaginatedAsyncDataNotifier<T> Function<T>() create) =>
      $FamilyOverride(
        from: this,
        createElement: (pointer) {
          final provider = pointer.origin as PaginatedAsyncDataNotifierProvider;
          return provider._captureGenerics(<T>() {
            provider as PaginatedAsyncDataNotifierProvider<T>;
            return provider.$view(create: create<T>).$createElement(pointer);
          });
        },
      );

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<PaginatedData<T>> Function<T>(
      Ref ref,
      PaginatedAsyncDataNotifier<T> notifier,
    )
    build,
  ) => $FamilyOverride(
    from: this,
    createElement: (pointer) {
      final provider = pointer.origin as PaginatedAsyncDataNotifierProvider;
      return provider._captureGenerics(<T>() {
        provider as PaginatedAsyncDataNotifierProvider<T>;
        return provider
            .$view(runNotifierBuildOverride: build<T>)
            .$createElement(pointer);
      });
    },
  );
}

abstract class _$PaginatedAsyncDataNotifier<T>
    extends $AsyncNotifier<PaginatedData<T>> {
  late final _$args =
      ref.$arg as (PaginatedAsyncDataParams<T>, {bool useOffset, int limit});
  PaginatedAsyncDataParams<T> get params => _$args.$1;
  bool get useOffset => _$args.useOffset;
  int get limit => _$args.limit;

  FutureOr<PaginatedData<T>> build(
    PaginatedAsyncDataParams<T> params, {
    bool useOffset = false,
    int limit = 15,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      useOffset: _$args.useOffset,
      limit: _$args.limit,
    );
    final ref =
        this.ref as $Ref<AsyncValue<PaginatedData<T>>, PaginatedData<T>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaginatedData<T>>, PaginatedData<T>>,
              AsyncValue<PaginatedData<T>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
