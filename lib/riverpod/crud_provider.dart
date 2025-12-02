import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_response.dart';
import 'riverpod_mixins.dart';

part 'crud_provider.g.dart';

class AsyncDataParams<T> {
  final String key;
  final FutureOr<ApiResponse<T>> Function() request;

  AsyncDataParams(this.key, {required this.request});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AsyncDataParams && other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

@riverpod
class AsyncDataNotifier<T> extends _$AsyncDataNotifier<T> {
  @override
  FutureOr<T> build(AsyncDataParams<T> params) async {
    try {
      final response = await params.request();

      if (response.isSuccessful) {
        return response.result as T;
      } else {
        final errorMsg = response.errorData ?? 'Unknown Error';
        throw Exception(errorMsg);
      }
    } catch (e, stack) {
      rethrow;
    }
  }

  Future<ApiResponse<T>> refresh({bool withPreviousValue = true}) async {
    if (withPreviousValue) {
      state = AsyncLoading<T>().copyWithPrevious(state);
    } else {
      state = const AsyncLoading();
    }

    try {
      final response = await params.request();

      if (response.isSuccessful) {
        state = AsyncData<T>(response.result as T);
        return response;
      } else {
        final errorMsg = response.errorData ?? 'Unknown Error';
        state = AsyncError<T>(Exception(errorMsg), StackTrace.current);
        return response;
      }
    } catch (e, stack) {
      state = AsyncError<T>(e, stack);
      rethrow;
    }
  }
}

class PaginatedAsyncDataParams<T> {
  final String key;
  final FutureOr<List<T>?> Function(int pageOrOffset) request;

  PaginatedAsyncDataParams(this.key, {required this.request});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginatedAsyncDataParams && other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

@riverpod
class PaginatedAsyncDataNotifier<T> extends _$PaginatedAsyncDataNotifier<T> {
  @override
  FutureOr<PaginatedData<T>> build(PaginatedAsyncDataParams<T> params, {bool useOffset = false, int limit = 15}) async {
    final initialPage = useOffset ? 0 : 1;
    final data = await params.request(initialPage);

    return PaginatedData(data: data ?? [], page: initialPage, reachedLimit: (data?.length ?? 0) < limit);
  }

  Future<void> loadMore({bool useOffset = false, int limit = 15, bool withPreviousValue = true}) async {
    if (state.value?.reachedLimit == true) {
      return;
    }

    final currentData = state.value!;
    final nextPageOrOffset = useOffset ? currentData.page + limit : currentData.page + 1;

    if (withPreviousValue) {
      state = AsyncLoading<PaginatedData<T>>().copyWithPrevious(state);
    } else {
      state = const AsyncLoading();
    }

    try {
      final newData = await params.request(nextPageOrOffset);
      final allData = List<T>.from(currentData.data)..addAll(newData ?? []);

      state = AsyncData(
        PaginatedData(data: allData, page: nextPageOrOffset, reachedLimit: (newData?.length ?? 0) < limit),
      );
    } catch (e, stack) {
      state = AsyncError<PaginatedData<T>>(e, stack).copyWithPrevious(state);
    }
  }
}
