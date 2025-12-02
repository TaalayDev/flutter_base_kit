sealed class AsyncResult<T> {
  const AsyncResult._(T? value) : _value = value;

  const factory AsyncResult.success(T data) = AsyncResultSuccess<T>;
  const factory AsyncResult.error(String? message, [T? previousValue]) = AsyncResultError<T>;
  const factory AsyncResult.empty() = AsyncResultEmpty<T>;
  const factory AsyncResult.loading([T? previousValue]) = AsyncResultLoading<T>;

  bool get isSuccess => this is AsyncResultSuccess;
  bool get isError => this is AsyncResultError;
  bool get isEmpty => this is AsyncResultEmpty;
  bool get isLoading => this is AsyncResultLoading;

  final T? _value;

  T get value {
    if (_value == null) {
      throw StateError('No value present');
    }
    return _value;
  }

  T? get valueOrNull => _value;

  String? get errorMessage => isError ? (this as AsyncResultError).message : null;

  AsyncResult<T> toLoading() {
    return AsyncResultLoading(_value);
  }

  R when<R>({
    required R Function(T value) success,
    required R Function(String? message, T? previousValue) error,
    required R Function() empty,
    required R Function(T? previousValue) loading,
  }) {
    return switch (this) {
      AsyncResultSuccess(value: final v) => success(v!),
      AsyncResultError(message: final m, valueOrNull: final v) => error(m, v),
      AsyncResultEmpty() => empty(),
      AsyncResultLoading(valueOrNull: final v) => loading(v),
    };
  }
}

class AsyncResultSuccess<T> extends AsyncResult<T> {
  const AsyncResultSuccess(T super.value) : super._();
}

class AsyncResultError<T> extends AsyncResult<T> {
  final String? message;

  const AsyncResultError(this.message, [super.previousValue]) : super._();
}

class AsyncResultEmpty<T> extends AsyncResult<T> {
  const AsyncResultEmpty() : super._(null);
}

class AsyncResultLoading<T> extends AsyncResult<T> {
  const AsyncResultLoading([super.previousValue]) : super._();

  AsyncResultLoading withPreviousValue(T value) {
    return AsyncResultLoading(value);
  }
}
