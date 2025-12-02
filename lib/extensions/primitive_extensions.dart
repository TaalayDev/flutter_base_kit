/// Utility methods for [num] type.
extension NumExtensions on num {
  /// Utility method for formatting time.
  String get timeFormat {
    String formatSeconds(num value) {
      if (value < 10) {
        return '0$value';
      }

      return '$value';
    }

    if (this >= 60) {
      final minutes = (this / 60).round();
      final seconds = this % 60;

      if (minutes < 10) {
        return '0$minutes:${formatSeconds(seconds)}';
      }

      return '$minutes:${formatSeconds(seconds)}';
    }

    return '00:${formatSeconds(this)}';
  }

  /// Utility method for formatting date.
  String get dateFormat {
    final value = this;

    if (value < 10) {
      return '0$value';
    }

    return '$value';
  }

  String toStringAsFixedRound(int fractionDigits) {
    final value = toStringAsFixed(fractionDigits);
    final parts = value.split('.');

    if (parts.length == 2 && parts[1] == ('0' * fractionDigits)) {
      return parts[0];
    }

    return value;
  }
}

/// Utility methods for [String] type.
extension StringExtensions on String {
  /// Utility method for formatting date.
  String get dateFormat {
    final value = this;

    if (value.length == 1) {
      return '0$value';
    }

    return value;
  }

  /// Utility method for formatting time.
  String get timeFormat {
    final value = this;

    if (value.length == 1) {
      return '0$value';
    }

    return value;
  }

  /// Utility method for formatting phone number.
  String get phoneFormat {
    final value = this;

    if (value.length == 1) {
      return '+7 ($value';
    }

    if (value.length == 4) {
      return '$value) ';
    }

    if (value.length == 7) {
      return '$value-';
    }

    return value;
  }

  /// Utility method for formatting currency.
  String get currencyFormat {
    final value = this;

    if (value.length == 1) {
      return '0$value';
    }

    return value;
  }

  /// Utility method for formatting currency.
  String get currencyFormatWithComma {
    final value = this;

    if (value.length == 1) {
      return '0,$value';
    }

    final parts = value.split('.');

    if (parts.length == 2) {
      return '${parts[0]},${parts[1]}';
    }

    return value;
  }

  /// Utility method for formatting currency.
  String get currencyFormatWithCommaAndSymbol {
    final value = this;

    if (value.length == 1) {
      return '0,$value ₽';
    }

    final parts = value.split('.');

    if (parts.length == 2) {
      return '${parts[0]},${parts[1]} ₽';
    }

    return '$value ₽';
  }

  /// Utility method for formatting currency.
  String get currencyFormatWithSymbol {
    final value = this;

    return '$value ₽';
  }

  /// Utility method for formatting currency.
  String get currencyFormatWithSymbolAndComma {
    final value = this;

    final parts = value.split('.');

    if (parts.length == 2) {
      return '${parts[0]},${parts[1]} ₽';
    }

    return '$value ₽';
  }

  /// Utility
  String get capitalize {
    final value = this;

    if (value.isEmpty) {
      return value;
    }

    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
