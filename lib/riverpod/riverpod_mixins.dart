import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../network/api_response.dart';

class PaginatedData<T> {
  final int page;
  final List<T> data;
  final bool reachedLimit;

  PaginatedData({required this.page, required this.data, this.reachedLimit = false});

  PaginatedData<T> copyWith({int? page, List<T>? data, bool? reachedLimit}) {
    return PaginatedData<T>(
      page: page ?? this.page,
      data: data ?? this.data,
      reachedLimit: reachedLimit ?? this.reachedLimit,
    );
  }
}

mixin NotifierRequestMixin<T, R> on AsyncNotifier<ApiResponse<R>> {
  Future<ApiResponse<R>> request(T data);

  Future<ApiResponse<R>?> send(T data) async {
    state = const AsyncLoading();

    try {
      final response = await request(data);

      if (response.isSuccessful) {
        state = AsyncData(response);
        return response;
      } else {
        final errorMsg = response.errorData ?? 'Unknown Error';
        state = AsyncError(errorMsg, StackTrace.current);
        return response;
      }
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}

mixin PaginationNotifierMixin<T> on AsyncNotifier<PaginatedData<T>> {
  int get limit => 15;
  bool get useOffset => false;

  @protected
  FutureOr<List<T>?> requestData(int pageOrOffset);

  Future<PaginatedData<T>> loadInitial() async {
    final initialPage = useOffset ? 0 : 1;
    final data = await requestData(initialPage);

    return PaginatedData(data: data ?? [], page: initialPage, reachedLimit: (data?.length ?? 0) < limit);
  }

  Future<void> loadMore() async {
    final currentState = state;
    final value = currentState.value;

    if (value == null || currentState.isLoading || currentState.hasError || value.reachedLimit) {
      return;
    }

    final nextPage = useOffset ? value.page + limit : value.page + 1;

    state = AsyncLoading<PaginatedData<T>>().copyWithPrevious(currentState);

    try {
      final newData = await requestData(nextPage);

      if (newData == null || newData.isEmpty) {
        state = AsyncData(value.copyWith(reachedLimit: true));
        return;
      }

      state = AsyncData(
        PaginatedData(page: nextPage, data: [...value.data, ...newData], reachedLimit: newData.length < limit),
      );
    } catch (e, stack) {
      state = AsyncError<PaginatedData<T>>(e, stack).copyWithPrevious(currentState);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await loadInitial());
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

/// Mixin for StateNotifier that handles AsyncValue<ApiResponse<R>>
mixin RequestStateNotifierMixin<T, R> on StateNotifier<AsyncValue<ApiResponse<R>>> {
  Future<ApiResponse<R>> request(T data);

  Future<ApiResponse<R>?> send(T data) async {
    state = const AsyncLoading();

    try {
      final response = await request(data);

      if (response.isSuccessful) {
        state = AsyncData(response);
        return response;
      } else {
        final errorMsg = response.errorData ?? 'Unknown Error';
        state = AsyncError(errorMsg, StackTrace.current);
        return response;
      }
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}

/// Mixin for StateNotifier that handles AsyncValue<PaginatedData<T>>
mixin PaginationStateNotifierMixin<T> on StateNotifier<AsyncValue<PaginatedData<T>>> {
  int get limit => 15;
  bool get useOffset => false;

  @protected
  FutureOr<List<T>?> requestData(int pageOrOffset);

  Future<PaginatedData<T>> loadInitial() async {
    final initialPage = useOffset ? 0 : 1;
    final data = await requestData(initialPage);

    return PaginatedData(data: data ?? [], page: initialPage, reachedLimit: (data?.length ?? 0) < limit);
  }

  Future<void> loadMore() async {
    final currentState = state;
    final value = currentState.value;

    if (value == null || currentState.isLoading || currentState.hasError || value.reachedLimit) {
      return;
    }

    final nextPage = useOffset ? value.page + limit : value.page + 1;

    state = AsyncLoading<PaginatedData<T>>().copyWithPrevious(currentState);

    try {
      final newData = await requestData(nextPage);

      if (newData == null || newData.isEmpty) {
        state = AsyncData(value.copyWith(reachedLimit: true));
        return;
      }

      state = AsyncData(
        PaginatedData(page: nextPage, data: [...value.data, ...newData], reachedLimit: newData.length < limit),
      );
    } catch (e, stack) {
      state = AsyncError<PaginatedData<T>>(e, stack).copyWithPrevious(currentState);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await loadInitial());
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

/// Mixin for StateNotifier<List<T>>
mixin SelectionStateNotifierMixin<T> on StateNotifier<List<T>> {
  void toggle(T item) {
    if (state.contains(item)) {
      state = state.where((element) => element != item).toList();
    } else {
      state = [...state, item];
    }
  }

  void select(T item) {
    if (!state.contains(item)) {
      state = [...state, item];
    }
  }

  void deselect(T item) {
    state = state.where((element) => element != item).toList();
  }

  void selectAll(List<T> items) {
    state = List.from(items);
  }

  void clear() {
    state = [];
  }

  bool isSelected(T item) => state.contains(item);
}
